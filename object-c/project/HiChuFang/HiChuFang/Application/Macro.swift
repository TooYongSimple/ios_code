//
//  Macro.swift
//  HiChuFang
//
//  Created by zhangjianyun on 16/8/25.
//  Copyright © 2016年 com.taihejiacheng. All rights reserved.
//

import UIKit

let BaseUrl = "http://api.haichufang.com/"

//屏幕宽度
let Screen_Width = UIScreen.main.bounds.size.width
//屏幕高度
let Screen_Height = UIScreen.main.bounds.size.height
//当前视图控制器的宽度
//let ViewControll_With = self.view.frame.size.width
//当前视图控制器的高度
//let ViewControll_Height = self.view.frame.size.height
//状态栏高度
let StatusBar_Height = UIApplication.shared.statusBarFrame.height
//导航栏高度
//let NavigationBar_Height = self.navigationController?.navigationBar.frame.size.height
//系统字体
var HH_SystemFont : (CGFloat) -> UIFont = {size in
    return UIFont.systemFont(ofSize: size)
}
//调用方法
var font = HH_SystemFont(10)
//根据RGBA生成颜色
var HH_Color : (CGFloat,CGFloat,CGFloat,CGFloat) -> UIColor = {red,green,blue,alpha in
    return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
}
//根据色值生成颜色(无透明度)
var HH_ColorWithHex : (NSInteger) -> UIColor = {hex in
    return UIColor(red: ((CGFloat)((hex & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((hex & 0xFF00) >> 8))/255.0, blue: ((CGFloat)(hex & 0xFF))/255.0, alpha: 1)
}

class Macro: NSObject {

}
