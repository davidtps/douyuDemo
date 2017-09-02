//
//  HomeViewController.swift
//  douyuDemo
//
//  Created by 田鹏升 on 2017/8/31.
//  Copyright © 2017年 田鹏升. All rights reserved.
//

import UIKit
private let mTitleViewH:CGFloat = 40
class HomeViewController: UIViewController {
    // MARK:- 懒加载 titleView  contentView
    fileprivate lazy var  pageTitleView:PageTitleView = {
        let titleFrame = CGRect(x: 0, y: mStatusBarH+mNavigationBarH, width: mScreenW, height: mTitleViewH)
        let titles  = ["推荐","游戏","娱乐","趣玩"]
        let titleview = PageTitleView(frame: titleFrame, titles: titles)
        return titleview
    }()
    
    fileprivate lazy var pageContentView:PageContentView = {[weak self] in
        let contentViewH = mScreenH - (mStatusBarH+mNavigationBarH+mTitleViewH)
        let contentFrame = CGRect(x: 0, y: mStatusBarH+mNavigationBarH+mTitleViewH, width: mScreenW, height: contentViewH)
        
        var childVcs:[UIViewController] = [UIViewController]()
        for _ in 0..<4{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentVc: self)
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    
}

extension HomeViewController{
    fileprivate func initUI(){
        //scrollview 不需要内边距
        automaticallyAdjustsScrollViewInsets = false
        // MARK:- 初始化导航栏UI
        navigationInit();
        // MARK:- 添加pageTitle
        view.addSubview(pageTitleView)
        // MARK:- 添加contentView
        view.addSubview(pageContentView)
    }
    
    func navigationInit()  {
      
        // 左侧，设置logo
        //        let logo = UIButton();
        //        logo.setImage(UIImage(named:"logo"), for: UIControlState.normal)
        //        logo.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(normal: "logo")
        
        //设置右侧 item
        let size = CGSize(width:40,height:40);
        //        let hisBtn = UIButton();
        //
        //        hisBtn.setImage(UIImage(named:"image_my_history"), for: UIControlState.normal)
        //        hisBtn.setImage(UIImage(named:"Image_my_history_click"), for: UIControlState.highlighted)
        //        hisBtn.frame = CGRect(origin: CGPoint.zero, size: size)
        //
        //        let scanBtn = UIButton();
        //        scanBtn.setImage(UIImage(named:"Image_scan"), for: UIControlState.normal)
        //        scanBtn.setImage(UIImage(named:"Image_scan_click"), for: UIControlState.highlighted)
        //        scanBtn.frame = CGRect(origin: CGPoint.zero, size: size)
        //
        //
        //        let searchBtn = UIButton();
        //        searchBtn.setImage(UIImage(named:"btn_search"), for: UIControlState.normal)
        //        searchBtn.setImage(UIImage(named:"btn_search_clicked"), for: UIControlState.highlighted)
        //        searchBtn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        
        let history = UIBarButtonItem(normal:"image_my_history",highlight:"Image_my_history_click",size:size)
        let scan = UIBarButtonItem(normal:"Image_scan",highlight:"Image_scan_click",size:size)
        let search = UIBarButtonItem(normal:"btn_search",highlight:"btn_search_clicked",size:size)
        
        navigationItem.rightBarButtonItems = [history,scan,search]
        
    }
    
    
}
