
//  UIBarButtonItem.swift
//  douyuDemo
//
//  Created by 田鹏升 on 2017/8/31.
//  Copyright © 2017年 田鹏升. All rights reserved.
//

import UIKit
extension UIBarButtonItem{
    /*
     // MARK:- 类方法的形式扩展
     class  func createItem(normal:String,highlight:String,size:CGSize) ->  UIBarButtonItem {
     let btn = UIButton();
     
     btn.setImage(UIImage(named:normal), for: UIControlState.normal)
     btn.setImage(UIImage(named:highlight), for: UIControlState.highlighted)
     btn.frame = CGRect(origin: CGPoint.zero, size: size)
     
     return UIBarButtonItem(customView:btn);
     }
     */
    //便利构造函数，1.	convenience开头 2.在构造函数中必须明确的调用已存在的构造函数（必须用self来调用）
    convenience init(normal:String,highlight:String="",size:CGSize=CGSize.zero) {
        let btn = UIButton();
        
        btn.setImage(UIImage(named:normal), for: UIControlState.normal)
        if(highlight != ""){
            btn.setImage(UIImage(named:highlight), for: UIControlState.highlighted)
        }
        if(size==CGSize.zero){
            btn.sizeToFit();
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        self.init(customView:btn)
    }
}
