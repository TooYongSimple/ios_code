//
//  HCFHomeViewController.swift
//  HiChuFang
//
//  Created by zhangjianyun on 16/8/25.
//  Copyright © 2016年 com.taihejiacheng. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class HCFHomeViewController: HCFBaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var dataArr : NSMutableArray = []
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.title = "首页"
        makeUI()
    }
    
    func makeUI() {
        //访问网络，初始化collectionview
        Alamofire.request(.GET, "\(BaseUrl)hp/homepage/getEventInfo").responseJSON { (resonse) in
            debugPrint(resonse)
            if resonse.result.isSuccess {
                if let dict = resonse.result.value as? NSDictionary {
                    for dic in (dict["result"] as! NSArray) {
                        let model = HCFHomeCollectionModel.init(dict: dic as! [String : AnyObject])
                        self.dataArr .add(model)
                    }
                    self.homeCollectionView.reloadData()
                }
            }
        }
    }
    //MARK: - collectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //?? 快速对nil 进行条件判断
        return self.dataArr.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HCFHomeCollectionViewCell
        cell.model = self.dataArr[indexPath.row] as? HCFHomeCollectionModel
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableView : HCFHomeHeaderReusableView!
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView .dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView", for: indexPath) as! HCFHomeHeaderReusableView
            headerView .configUI()
            reusableView = headerView
        }
        return reusableView
    }
    // MARK: - UICollectionViewLayoutDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: Screen_Width/2, height: Screen_Width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
