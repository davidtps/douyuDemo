//
//  CustomTabBarItem.swift
//  douyuDemo
//
//  Created by 田鹏升 on 2017/8/30.
//  Copyright © 2017年 田鹏升. All rights reserved.
//

import UIKit
// MARK:- 自定义  tabbar item
class CustomTabBarItem: UITabBarItem {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.darkGray], for:.normal)
        setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.orange], for: .selected)
        
        
    }
    
    
    
}
