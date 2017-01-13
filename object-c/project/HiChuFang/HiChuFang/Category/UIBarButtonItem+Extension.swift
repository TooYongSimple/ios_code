//
//  UIBarButtonItem+Extension.swift
//  HiChuFang
//
//  Created by zhangjianyun on 16/8/25.
//  Copyright © 2016年 com.taihejiacheng. All rights reserved.
//

import UIKit


extension UIBarButtonItem {
    //用一张图片初始化左边的按钮
    class func barButtonLeft(_ imageName: NSString, target: AnyObject, action:(Selector)) -> AnyObject {
        let button = UIButton.init(frame: CGRect(x: 0, y: 0, width: 30, height: 32))
        button.setImage(UIImage.init(named: imageName as String), for: UIControlState())
        button.addTarget(target, action: action, for: .touchUpInside)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8)
        let barButtonItem = UIBarButtonItem.init(customView: button)
        return barButtonItem;
    }
    //用带字的背景图片初始化左边的按钮
    class func barButtonLeft(_ imageName: NSString, title: NSString, target:AnyObject, action:(Selector)) -> AnyObject {
        let button = UIButton.init(frame: CGRect(x: 0, y: 0, width: 45, height: 15))
        button.setBackgroundImage(UIImage.init(named: imageName as String), for: UIControlState())
        button.setTitle(title as String, for: UIControlState())
        button.setTitleColor(UIColor.red, for: UIControlState())
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8)
        let barButtonItem = UIBarButtonItem.init(customView: button)
        return barButtonItem;
    }
    
    //用字初始化右边的按钮
}
