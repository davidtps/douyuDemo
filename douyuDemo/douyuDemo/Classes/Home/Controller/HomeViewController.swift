//
//  HomeViewController.swift
//  douyuDemo
//
//  Created by 田鹏升 on 2017/8/31.
//  Copyright © 2017年 田鹏升. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
    }
    
    
}

extension HomeViewController{
    fileprivate func initUI(){
        navigationInit();
    }
    
    func navigationInit()  {
        // 左侧，设置logo
        let logo = UIButton();
        logo.setImage(UIImage(named:"logo"), for: UIControlState.normal)
        logo.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: logo)
        
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
        
        
        let history = UIBarButtonItem.createItem(normal:"image_my_history",highlight:"Image_my_history_click",size:size)
        let scan = UIBarButtonItem.createItem(normal:"Image_scan",highlight:"Image_scan_click",size:size)
        let search = UIBarButtonItem.createItem(normal:"btn_search",highlight:"btn_search_clicked",size:size)
        
        navigationItem.rightBarButtonItems = [history,scan,search]
        
    }
    
    
}
