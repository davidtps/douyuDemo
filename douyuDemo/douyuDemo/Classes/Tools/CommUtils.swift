//
//  CommUtils.swift
//  douyuDemo
//
//  Created by 田鹏升 on 2017/9/2.
//  Copyright © 2017年 田鹏升. All rights reserved.
//

import UIKit

func printLog<T>(_ message:T,file:String=#file,method:String = #function ,line:Int  = #line){
    //什么语法？？
    #if DEBUG
    print("文件名:\((file as NSString).lastPathComponent)[行数:\(line)],方法名:\(method) 输出信息:\(message)")
    #endif
}


                                                                                        
