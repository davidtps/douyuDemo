//
//  UIBarButtonItem.swift
//  douyuDemo
//
//  Created by 田鹏升 on 2017/8/31.
//  Copyright © 2017年 田鹏升. All rights reserved.
//

import UIKit
extension UIBarButtonItem{
   class  func createItem(normal:String,highlight:String,size:CGSize) ->  UIBarButtonItem {
        let btn = UIButton();
    
        btn.setImage(UIImage(named:normal), for: UIControlState.normal)
        btn.setImage(UIImage(named:highlight), for: UIControlState.highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
    
        return UIBarButtonItem(customView:btn);
    }
}
