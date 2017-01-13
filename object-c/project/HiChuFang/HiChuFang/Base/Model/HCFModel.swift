//
//  HCFModel.swift
//  HiChuFang
//
//  Created by zhangjianyun on 16/9/1.
//  Copyright © 2016年 com.taihejiacheng. All rights reserved.
//

import UIKit

class HCFModel: NSObject {
    //var h_id : NSNumber

    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
       
    }
}
