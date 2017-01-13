2016年6月22日 at 上午12:49
From Apple

    0.3.0 - iOS Data Storage

Before you Submit


On launch and content download, your app stores 9.56MB on the user's iCloud, which does not comply with the iOS Data Storage Guidelines.

Next Steps

Please verify that only the content that the user creates using your app, e.g., documents, new files, edits, etc. is backed up by iCloud as required by the iOS Data Storage Guidelines. Also, check that any temporary files used by your app are only stored in the /tmp directory; please remember to remove or delete the files stored in this location when it is determined they are no longer needed.

Data that can be recreated but must persist for proper functioning of your app - or because users expect it to be available for offline use - should be marked with the "do not back up" attribute. For NSURL objects, add the NSURLIsExcludedFromBackupKey attribute to prevent the corresponding file from being backed up. For CFURLRef objects, use the corresponding kCRUFLIsExcludedFromBackupKey attribute.

Resources

For additional information on preventing files from being backed up to iCloud and iTunes, see Technical Q&A 1719: How do I prevent files from being backed up to iCloud and iTunes.

If you have difficulty reproducing a reported issue, please try testing the workflow described in Technical Q&A QA1764: How to reproduce bugs reported against App Store submissions.

If you have code-level questions after utilizing the above resources, you may wish to consult with Apple Developer Technical Support. When the DTS engineer follows up with you, please be ready to provide:
- complete details of your rejection issue(s)
- screenshots
- steps to reproduce the issue(s)
- symbolicated crash logs - if your issue results in a crash log
