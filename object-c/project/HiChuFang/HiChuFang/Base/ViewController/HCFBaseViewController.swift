//
//  HCFBaseViewController.swift
//  HiChuFang
//
//  Created by zhangjianyun on 16/8/25.
//  Copyright © 2016年 com.taihejiacheng. All rights reserved.
//

import UIKit

class HCFBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonLeftItemWithImageName:imageStr trget:self action:@selector(didClickOnLeftBarButton)];
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.barButtonLeft("back", target: self, action: #selector(HCFBaseViewController.didClickOnLeftBarButton)) as? UIBarButtonItem
    }

    func didClickOnLeftBarButton() -> () {
        self.navigationController?.popViewController(animated: true)
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
