//
//  PageContentView.swift
//  douyuDemo
// 自定义pageContentView
//  Created by 田鹏升 on 2017/9/1.
//  Copyright © 2017年 田鹏升. All rights reserved.
//

import UIKit

private let contentCellId:String  = "ContentCellId"

class PageContentView:UIView{
    // MARK:- 属性
    
    fileprivate var childVcs:[UIViewController]
    fileprivate weak var parentVc:UIViewController?
    // MARK:- 懒加载属性
    lazy var collectionView : UICollectionView = {[weak self] in
        // 创建 collectionView 布局
        let collLayout = UICollectionViewFlowLayout()
        collLayout.itemSize = (self?.bounds.size)!
        collLayout.minimumLineSpacing = 0
        collLayout.minimumInteritemSpacing = 0
        collLayout.scrollDirection = .horizontal
        
        // 创建 UICollectionView
        let collectView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collLayout)
        collectView.isPagingEnabled = true
        collectView.showsHorizontalScrollIndicator = false
        collectView.bounces = false
        collectView.dataSource = self
        collectView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellId)
        
        return collectView
    }()
    
    
    init(frame: CGRect,childVcs:[UIViewController],parentVc:UIViewController?) {
        self.childVcs = childVcs
        self.parentVc = parentVc
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK:- 初始化UI
extension PageContentView{
    func initUI()  {
        //添加childViewC 到 parentViewController
        for childVc  in childVcs{
            parentVc?.addChildViewController(childVc)
        }
        //添加 collectionView
        addSubview(collectionView)
        collectionView.frame = bounds
        
        
    }
}

// MARK:- 遵守UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //创建cell
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: contentCellId, for: indexPath)
        
        for view in cell.contentView.subviews{
           view.removeFromSuperview()
        }
        
        //给cell 添加内容
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}

