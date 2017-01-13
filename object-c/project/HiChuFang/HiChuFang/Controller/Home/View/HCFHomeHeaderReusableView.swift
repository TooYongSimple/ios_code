//
//  HCFHomeHeaderReusableView.swift
//  HiChuFang
//
//  Created by zhangjianyun on 16/9/2.
//  Copyright © 2016年 com.taihejiacheng. All rights reserved.
//

import UIKit
import Alamofire

class HCFHomeHeaderReusableView: UICollectionReusableView,CirCleViewDelegate {
    
    //轮播图
    @IBOutlet weak var bannerView: CirCleView!
    //活动页的四个活动
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var oneImageView: UIImageView!
    @IBOutlet weak var twoImageView: UIImageView!
    @IBOutlet weak var threeImageView: UIImageView!
    @IBOutlet weak var fourImageView: UIImageView!
    @IBOutlet weak var oneLabel: UILabel!
    @IBOutlet weak var twoLabel: UILabel!
    @IBOutlet weak var threeLabel: UILabel!
    @IBOutlet weak var fourLabel: UILabel!
    //秒杀和食谱页
    @IBOutlet weak var secKillAndFoodView: UIView!
    //秒杀页
    @IBOutlet weak var goodsNameLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var goodsImageView: UIImageView!
    //倒计时
    var totalNumber: Int = 0
    //食谱页
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    //每日食谱
    @IBOutlet weak var everydayFoodView: UIView!
    @IBOutlet weak var everyDayFoodImageView: UIImageView!
    
    //需要的数据
    
    lazy var activitys : NSMutableArray = []
    lazy var secKillDic : NSDictionary = [:]
    lazy var foods : NSMutableArray = []
    lazy var everydayGoods : NSMutableArray = []
    
    func configUI() {
        self.initBannerData()
        self.makeActivityData()
        self.makeSecKillData()
        self.makeFoodData()
        self.makeEveryDayFoodData()
        
    }
    
    lazy var banners : NSMutableArray = []
    
    func initBannerData() {
        //访问网络，初始化collectionview
        Alamofire.request(.GET, "\(BaseUrl)hp/homepage/getSliderInfo").responseJSON { (resonse) in
            debugPrint(resonse)
            if resonse.result.isSuccess {
                if let dict = resonse.result.value as? NSDictionary {
                    for dic in (dict["result"] as! NSArray) {
                        self.banners .add(dic)
                    }
                    self .makeBannerView()
                }
            }
        }
    }
    
    func makeBannerView() {
        
    }
    
    func makeActivityData() {
        Alamofire.request(.GET, "\(BaseUrl)hp/homepage/getButtonInfo").responseJSON { (resonse) in
            debugPrint(resonse)
            if resonse.result.isSuccess {
                if let dict = resonse.result.value as? NSDictionary {
                    for dic in (dict["result"] as! NSArray) {
                        self.activitys.add(dic)
                    }
                    self.makeActivityView()
                }
            }
        }
    }
    
    func makeActivityView() {
        
        self.oneImageView .kf_setImageWithURL(URL(string: self.activitys[0]["imgUrl"] as! String))
        self.twoImageView .kf_setImageWithURL(URL(string: self.activitys[1]["imgUrl"] as! String))
        self.threeImageView .kf_setImageWithURL(URL(string: self.activitys[2]["imgUrl"] as! String))
        self.fourImageView .kf_setImageWithURL(URL(string: self.activitys[3]["imgUrl"] as! String))

        self.oneLabel.text = self.activitys[0]["title"] as? String
        self.twoLabel.text = self.activitys[1]["title"] as? String
        self.threeLabel.text = self.activitys[2]["title"] as? String
        self.fourLabel.text = self.activitys[3]["title"] as? String
    }
    
    func makeSecKillData() {
        Alamofire.request(.GET, "\(BaseUrl)hp/homepageseckill/homeSeckill").responseJSON { (resonse) in
            debugPrint(resonse)
            if resonse.result.isSuccess {
                if let dict = resonse.result.value as? NSDictionary {
                    let string = dict["surplusTime"] as! String
                    self.totalNumber = Int(string)!
                    self.secKillDic = dict["result"] as! NSDictionary
                    self.makeSecKillView()
                }
            }
        }

    }
    
    func makeSecKillView() {
        self.goodsNameLabel.text = self.secKillDic["goodsName"] as? String
        self.goodsImageView .kf_setImageWithURL(URL(string: self.secKillDic["goodsImgPath"] as! String))
        self.priceLabel.text = self.secKillDic["seckillPrice"] as? String
        self .daojishi()
    }
    
    func daojishi() {
        var _timeout: Int = self.totalNumber
        let _queue: DispatchQueue = DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default)
        let _timer: DispatchSource = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags(rawValue: 0), queue: _queue) as! DispatchSource
        
        // 每秒执行
        _timer.setTimer(start: DispatchWallTime(time: nil), interval: 1 * NSEC_PER_SEC, leeway: 0)
        
        _timer.setEventHandler { () -> Void in
            
            if _timeout <= 0 {
                
                // 倒计时结束
                _timer.cancel()
                
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    self.hourLabel.text = "00"
                    self.minuteLabel.text = "00"
                    self.secondLabel.text = "00"
                })
                
            } else {
                let hours: Int = _timeout/3600
                let minute: Int = (_timeout-hours*3600)/60
                let second: Int = _timeout-hours*3600-minute*60

                DispatchQueue.main.async(execute: { () -> Void in
                    self.hourLabel.text = NSString(format:"%02d",hours) as String
                    self.minuteLabel.text = NSString(format:"%02d",minute) as String
                    self.secondLabel.text = NSString(format:"%02d",second) as String
                })
                _timeout -= 1
            }
        }
        
        _timer.resume()
    }

    
    func makeFoodData() {
        Alamofire.request(.GET, "\(BaseUrl)hp/homepage/getRecipes").responseJSON { (resonse) in
            debugPrint(resonse)
            if resonse.result.isSuccess {
                if let dict = resonse.result.value as? NSDictionary {
                    for dic in (dict["result"] as! NSArray) {
                        self.foods .add(dic)
                    }
                    self.makeFoodView()
                }
            }
        }
    }
    
    func makeFoodView() {
        self.foodImageView .kf_setImageWithURL(URL(string: self.foods[0]["imgUrl"] as! String))
        self.foodNameLabel.text = self.foods[0]["title"] as? String
    }
    
    func makeEveryDayFoodData() {
        Alamofire.request(.GET, "\(BaseUrl)hp/homepage/getEverdayFood").responseJSON { (resonse) in
            debugPrint(resonse)
            if resonse.result.isSuccess {
                if let dict = resonse.result.value as? NSDictionary {
                    for dic in (dict["result"] as! NSArray) {
                        self.everydayGoods .add(dic)
                    }
                    self.makeEveryDayFoodView()
                }
            }
        }
    }
    
    func makeEveryDayFoodView() {
        self.everyDayFoodImageView .kf_setImageWithURL(URL(string: self.everydayGoods[0]["imgUrl"] as! String))
    }
    
}
