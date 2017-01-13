//
//  UIColor+Extension.swift
//  HiChuFang
//
//  Created by zhangjianyun on 16/8/25.
//  Copyright © 2016年 com.taihejiacheng. All rights reserved.
//

import UIKit

extension UIColor {
    class fileprivate func colorWithRGBHex(_ RGBHex:UInt32) -> UIColor {
        let r:CGFloat = (CGFloat)((RGBHex >> 16) & 0xFF)
        let g:CGFloat = (CGFloat)((RGBHex >> 8) & 0xFF)
        let b:CGFloat = (CGFloat)(RGBHex & 0xFF)
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
    }
    
    class func colorWithHexString(_ hexString: String) -> UIColor {
        let scanner = Scanner.init(string: hexString)
        var hexNum:UInt32 = 0
        if scanner.scanHexInt32(&hexNum) == false {
            return UIColor.clear
        }
        else {
            return UIColor.colorWithRGBHex(hexNum)
        }
        
        
    }
}
