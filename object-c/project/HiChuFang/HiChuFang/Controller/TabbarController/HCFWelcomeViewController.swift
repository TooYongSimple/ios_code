//
//  HCFWelcomeViewController.swift
//  HiChuFang
//
//  Created by zhangjianyun on 16/9/1.
//  Copyright © 2016年 com.taihejiacheng. All rights reserved.
//

import UIKit

class HCFWelcomeViewController: HCFBaseViewController,UIScrollViewDelegate {

    @IBOutlet weak var contentWidth: NSLayoutConstraint!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentWidth.constant = Screen_Width
    }

    @IBAction func tapOnPage(_ sender: UITapGestureRecognizer) {
        UserDefaults.standard.set(false, forKey: "firstLaunch")
        let tabbar = self.storyboard?.instantiateViewController(withIdentifier: "HCFTabBarViewController")
        self.view.window?.rootViewController = tabbar
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.pageControl.currentPage = NSInteger(scrollView.contentOffset.x / Screen_Width)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
