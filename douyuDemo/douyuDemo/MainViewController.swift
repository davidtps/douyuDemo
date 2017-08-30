//
//  ViewController.swift
//  douyuDemo
//
//  Created by 田鹏升 on 2017/8/30.
//  Copyright © 2017年 田鹏升. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        addTab(param: "Home");
        addTab(param: "Live");
        addTab(param: "Follow");
        addTab(param: "Profile");
        
        
    }
    
    
    func addTab( param :String) {
        let view = UIStoryboard.init(name: param, bundle: nil).instantiateInitialViewController();
        
        addChildViewController(view!);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

