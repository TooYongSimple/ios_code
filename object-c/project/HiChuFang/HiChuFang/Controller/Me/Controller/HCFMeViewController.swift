//
//  HCFMeViewController.swift
//  HiChuFang
//
//  Created by zhangjianyun on 16/8/25.
//  Copyright © 2016年 com.taihejiacheng. All rights reserved.
//

import UIKit

class HCFMeViewController: HCFBaseViewController {
    @IBOutlet weak var redView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.title = "我的账户"
        self.redView.backgroundColor = UIColor.colorWithHexString("e0e0e0")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
