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
    fileprivate var startOffsetX:CGFloat = 0
    fileprivate var childVcs:[UIViewController]
    fileprivate weak var parentVc:UIViewController?
    weak var delegate : PageContentViewDelegate?
    fileprivate var isForbidScrollDelegate:Bool = false;//是否禁止 滑动代理通知
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
        collectView.delegate = self  //必须要有的，相当于事件注册！！
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
protocol PageContentViewDelegate : class{
    func pageScrollEvent(pageContentView : PageContentView,progress : CGFloat ,sourceIndex: Int,targetIndex:Int)
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

// MARK:- 对外调用的方法
extension PageContentView{
    func setSelectedPage(index :Int){
        isForbidScrollDelegate = true;
        let offectX = CGFloat(index) * frame.width
        collectionView.setContentOffset( CGPoint.init(x: offectX, y: 0), animated: true)
    }
    
}

// MARK:- 滑动事件
extension PageContentView : UICollectionViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false;
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //判断是否禁止代理通知
        if isForbidScrollDelegate {
            return;
        }
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        let currOffsetX = scrollView.contentOffset.x
        let scrollviewW = scrollView.bounds.width
        if(currOffsetX > startOffsetX){//左滑
            //progress 值
            progress = currOffsetX/scrollviewW - floor(currOffsetX/scrollviewW)
            //sourceIndex 值
            sourceIndex = Int(currOffsetX/scrollviewW)
            //targetIndex 值
            targetIndex = sourceIndex + 1
            
            if targetIndex >= childVcs.count{
                targetIndex = childVcs.count - 1
            }
            
            //如果完全划过后
            if(progress == 0){
                progress = 1;
                targetIndex = sourceIndex;
                sourceIndex = sourceIndex - 1;
            }
            
        }else{//右滑
            //progress 值
            progress = 1 - (currOffsetX/scrollviewW - floor(currOffsetX/scrollviewW))
            //targetIndex 值
            targetIndex = Int(currOffsetX/scrollviewW)
            //sourceIndex 值
            sourceIndex = targetIndex + 1
            
            if sourceIndex >= childVcs.count{
                sourceIndex = childVcs.count - 1
            }
            
        }
        delegate?.pageScrollEvent(pageContentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
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

