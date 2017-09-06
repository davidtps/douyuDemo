//
//  RecommendViewController.swift
//  douyuDemo
//
//  Created by 田鹏升 on 2017/9/5.
//  Copyright © 2017年 田鹏升. All rights reserved.
//

import UIKit

//属性
fileprivate let mItemMargin:CGFloat = 10;
fileprivate let mItemW:CGFloat  = (mScreenW - 3 * mItemMargin) / 2;
fileprivate let mItemH:CGFloat  = mItemW * 3 / 4;
fileprivate let mSectionHeaderH : CGFloat = 60;
fileprivate let mNormalId:String = "mNormalId";
fileprivate let mSectionHeadId:String = "mSectionHeadId";


class RecommendViewController: UIViewController {
    
    
    //懒加载
    fileprivate lazy var recommendCollection : UICollectionView = {[unowned self] in
        //创建流布局
        let layout = UICollectionViewFlowLayout();
        layout.itemSize = CGSize(width: mItemW, height: mItemH);
        layout.minimumInteritemSpacing = mItemMargin;
        layout.minimumLineSpacing = 0;
        layout.headerReferenceSize = CGSize(width: mScreenW, height: mSectionHeaderH);
        layout.sectionInset = UIEdgeInsets(top: 0, left: mItemMargin, bottom: 0, right: mItemMargin);
        
        //创建 uiCollectionView
        let recommCollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout);
        recommCollectionView.dataSource = self;
        //自适用， 展示空间
        recommCollectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        // 1 cell view
        recommCollectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: mNormalId);
        // 2 header section
        recommCollectionView.register(UINib(nibName: "CollectionHeadView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: mSectionHeadId)
        
        return recommCollectionView;
        
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化UI
        initUI();
        
        
    }
    
    
    
}

extension RecommendViewController{
    fileprivate func initUI(){
        //将uiCollectionVeiw 添加到页面
        view.addSubview(recommendCollection);
        recommendCollection.backgroundColor = UIColor.white;
        
    }
}

extension RecommendViewController:UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0){
            return 8;
        }
        return 4;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mNormalId, for: indexPath);
        
        //
        return cell;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 获取  section head
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: mSectionHeadId, for: indexPath);
        
        return headView;
    }
}
