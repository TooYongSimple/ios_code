//
//  VideoDownloader.swift
//  WWDC
//
//  Created by Guilherme Rambo on 22/04/15.
//  Copyright (c) 2015 Guilherme Rambo. All rights reserved.
//

import Cocoa


public let VideoStoreDownloadedFilesChangedNotification = "VideoStoreDownloadedFilesChangedNotification"
public let VideoStoreNotificationDownloadStarted = "VideoStoreNotificationDownloadStarted"
public let VideoStoreNotificationDownloadCancelled = "VideoStoreNotificationDownloadCancelled"
public let VideoStoreNotificationDownloadPaused = "VideoStoreNotificationDownloadPaused"
public let VideoStoreNotificationDownloadResumed = "VideoStoreNotificationDownloadResumed"
public let VideoStoreNotificationDownloadFinished = "VideoStoreNotificationDownloadFinished"
public let VideoStoreNotificationDownloadProgressChanged = "VideoStoreNotificationDownloadProgressChanged"

private let _SharedVideoStore = VideoStore()
private let _BackgroundSessionIdentifier = "WWDC Video Downloader"

class VideoStore : NSObject, NSURLSessionDownloadDelegate {

    private let configuration = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier(_BackgroundSessionIdentifier)
    private var backgroundSession: NSURLSession!
    private var downloadTasks: [String : NSURLSessionDownloadTask] = [:]
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    class func SharedStore() -> VideoStore
    {
        return _SharedVideoStore;
    }
    
    override init() {
        super.init()
        backgroundSession = NSURLSession(configuration: configuration, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
    }
    
    func initialize() {
        backgroundSession.getTasksWithCompletionHandler { _, _, pendingTasks in
            for task in pendingTasks {
                if let key = task.originalRequest?.URL!.absoluteString {
                    self.downloadTasks[key] = task
                }
            }
        }
        
        NSNotificationCenter.defaultCenter().addObserverForName(LocalVideoStoragePathPreferenceChangedNotification, object: nil, queue: nil) { _ in
            self.monitorDownloadsFolder()
            NSNotificationCenter.defaultCenter().postNotificationName(VideoStoreDownloadedFilesChangedNotification, object: nil)
        }
        
        monitorDownloadsFolder()
    }
    
    // MARK: Public interface
	
	func allTasks() -> [NSURLSessionDownloadTask] {
		return Array(self.downloadTasks.values)
	}
	
    func download(url: String) {
        if isDownloading(url) || hasVideo(url) {
            return
        }
        
        let task = backgroundSession.downloadTaskWithURL(NSURL(string: url)!)
		if let key = task.originalRequest?.URL!.absoluteString {
			self.downloadTasks[key] = task
		}
        task.resume()
		
        NSNotificationCenter.defaultCenter().postNotificationName(VideoStoreNotificationDownloadStarted, object: url)
    }
    
    func pauseDownload(url: String) -> Bool {
        if let task = downloadTasks[url] {
			task.suspend()
			NSNotificationCenter.defaultCenter().postNotificationName(VideoStoreNotificationDownloadPaused, object: url)
			return true
        }
		print("VideoStore was asked to pause downloading URL \(url), but there's no task for that URL")
		return false
    }
	
	func resumeDownload(url: String) -> Bool {
		if let task = downloadTasks[url] {
			task.resume()
			NSNotificationCenter.defaultCenter().postNotificationName(VideoStoreNotificationDownloadResumed, object: url)
			return true
		}
		print("VideoStore was asked to resume downloading URL \(url), but there's no task for that URL")
		return false
	}
	
	func cancelDownload(url: String) -> Bool {
		if let task = downloadTasks[url] {
			task.cancel()
			self.downloadTasks.removeValueForKey(url)
			NSNotificationCenter.defaultCenter().postNotificationName(VideoStoreNotificationDownloadCancelled, object: url)
			return true
		}
		print("VideoStore was asked to cancel downloading URL \(url), but there's no task for that URL")
		return false
	}
	
    func isDownloading(url: String) -> Bool {
        let downloading = downloadTasks.keys.filter { taskURL in
            return url == taskURL
        }

        return (downloading.count > 0)
    }
    
    func localVideoPath(remoteURL: String) -> String {
        return (Preferences.SharedPreferences().localVideoStoragePath as NSString).stringByAppendingPathComponent((remoteURL as NSString).lastPathComponent)
    }
    
    func localVideoAbsoluteURLString(remoteURL: String) -> String {
        return NSURL(fileURLWithPath: localVideoPath(remoteURL)).absoluteString
    }
    
    func hasVideo(url: String) -> Bool {
        return (NSFileManager.defaultManager().fileExistsAtPath(localVideoPath(url)))
    }
    
    enum RemoveDownloadResponse {
        case NotDownloaded, Removed, Error(_:ErrorType)
    }
    
    func removeDownload(url: String) -> RemoveDownloadResponse {
        if isDownloading(url) {
            cancelDownload(url)
            return .Removed
        }
        
        if hasVideo(url) {
            let path = localVideoPath(url)
            let absolute = localVideoAbsoluteURLString(url)
            do {
                try NSFileManager.defaultManager().removeItemAtPath(path)
                WWDCDatabase.sharedDatabase.updateDownloadedStatusForSessionWithURL(absolute, downloaded: false)
                return .Removed
            } catch let e {
                return .Error(e)
            }
        } else {
            return .NotDownloaded
        }
    }
    
    // MARK: URL Session
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        let originalURL = downloadTask.originalRequest!.URL!
        let originalAbsoluteURLString = originalURL.absoluteString

        let fileManager = NSFileManager.defaultManager()
        
        if (fileManager.fileExistsAtPath(Preferences.SharedPreferences().localVideoStoragePath) == false) {
            do {
                try fileManager.createDirectoryAtPath(Preferences.SharedPreferences().localVideoStoragePath, withIntermediateDirectories: false, attributes: nil)
            } catch _ {
            }
        }
        
        let localURL = NSURL(fileURLWithPath: localVideoPath(originalAbsoluteURLString))
        
        do {
            try fileManager.moveItemAtURL(location, toURL: localURL)
            WWDCDatabase.sharedDatabase.updateDownloadedStatusForSessionWithURL(originalAbsoluteURLString, downloaded: true)
        } catch _ {
            print("VideoStore was unable to move \(location) to \(localURL)")
        }
        
        downloadTasks.removeValueForKey(originalAbsoluteURLString)
        
        NSNotificationCenter.defaultCenter().postNotificationName(VideoStoreNotificationDownloadFinished, object: originalAbsoluteURLString)
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let originalURL = downloadTask.originalRequest!.URL!.absoluteString

        let info = ["totalBytesWritten": Int(totalBytesWritten), "totalBytesExpectedToWrite": Int(totalBytesExpectedToWrite)]
        NSNotificationCenter.defaultCenter().postNotificationName(VideoStoreNotificationDownloadProgressChanged, object: originalURL, userInfo: info)
    }
    
    // MARK: File observation
    
    private var folderMonitor: DTFolderMonitor!
    private var existingVideoFiles = [String]()
    
    func monitorDownloadsFolder() {
        if folderMonitor != nil {
            folderMonitor.stopMonitoring()
            folderMonitor = nil
        }
        
        let videosPath = Preferences.SharedPreferences().localVideoStoragePath
        enumerateVideoFiles(videosPath)
        
        folderMonitor = DTFolderMonitor(forURL: NSURL(fileURLWithPath: videosPath)) {
            self.enumerateVideoFiles(videosPath)
            
            NSNotificationCenter.defaultCenter().postNotificationName(VideoStoreDownloadedFilesChangedNotification, object: nil)
        }
        folderMonitor.startMonitoring()
    }
    
    /// Updates the downloaded status for the sessions on the database based on the existence of the downloaded video file
    private func enumerateVideoFiles(path: String) {
        guard let enumerator = NSFileManager.defaultManager().enumeratorAtPath(path) else { return }
        guard let files = enumerator.allObjects as? [String] else { return }
        
        // existing/added files
        for file in files {
            WWDCDatabase.sharedDatabase.updateDownloadedStatusForSessionWithLocalFileName(file, downloaded: true)
        }
        
        if existingVideoFiles.count == 0 {
            existingVideoFiles = files
            return
        }
        
        // removed files
        let removedFiles = existingVideoFiles.filter { !files.contains($0) }
        for file in removedFiles {
            WWDCDatabase.sharedDatabase.updateDownloadedStatusForSessionWithLocalFileName(file, downloaded: false)
        }
    }
    
    // MARK: Teardown
    
    deinit {
        if folderMonitor != nil {
            folderMonitor.stopMonitoring()
        }
    }
    
}
