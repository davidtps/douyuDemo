//
//  UIColor_ext.swift
//  douyuDemo
//
//  Created by 田鹏升 on 2017/9/1.
//  Copyright © 2017年 田鹏升. All rights reserved.
//

import UIKit

extension UIColor{
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat){
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
        
    }
}
