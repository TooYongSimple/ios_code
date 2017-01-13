//
//  HCFHomeCollectionViewCell.swift
//  HiChuFang
//
//  Created by zhangjianyun on 16/9/1.
//  Copyright © 2016年 com.taihejiacheng. All rights reserved.
//

import UIKit

class HCFHomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var naleLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var activityPriceLabel: UILabel!
    @IBOutlet weak var goodsImageView: UIImageView!
    
    var model: HCFHomeCollectionModel? {
        didSet {
            self.goodsImageView.kf_setImageWithURL(URL(string: model!.goodsImgPath!))
            self.naleLabel.text = model!.goodsName
            self.weightLabel.text = model!.goodsSpe
            self.priceLabel.text = "￥" + model!.saleReferencePrice!
            self.activityPriceLabel.text = "￥" + model!.activityPrice!
        }
    }
}
