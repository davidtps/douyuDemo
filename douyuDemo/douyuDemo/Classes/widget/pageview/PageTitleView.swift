//
//  PageTitleView.swift
//  douyuDemo
// 自定义pageTitle控件
//  Created by 田鹏升 on 2017/8/31.
//  Copyright © 2017年 田鹏升. All rights reserved.
//

import UIKit

class PageTitleView: UIView {
    fileprivate var mScrollLineH:CGFloat = 2;
    //声明变量 声明数组
    fileprivate var titles:[String]
    //声明scrollview
    fileprivate lazy var scrollView:UIScrollView={
        let scroll  = UIScrollView()
        scroll.scrollsToTop = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.bounces = false
        return scroll
    }()
    //声明 scrollLine
    fileprivate lazy var scrollLine:UIView = {
        let line  = UIView();
        line.backgroundColor = UIColor.orange
        return line
    }()
    
    fileprivate lazy var labels:[UILabel] = [UILabel]()
    
    //自定义构造函数
    init(frame: CGRect,titles:[String]) {
        self.titles = titles;
        super.init(frame: frame)
        //初始化 ui
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {//自定义构造函数，必须实现的
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageTitleView{
    fileprivate func initUI(){
        //添加 scrollview到页面
        addSubview(scrollView)
        scrollView.frame = bounds

        //初始化，添加页签
        initTitleLabels();
        
        //页签底部的线和滑动指示线
        initTitleBottomLineAndScrollLine()
    }
    
    fileprivate func initTitleLabels(){
        for (index,title) in titles.enumerated() {
            //label 声明
            let label  = UILabel()
            //属性赋值
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.black
            label.textAlignment = .center
            
            //设置label 的frame
            let labelW:CGFloat = frame.width / CGFloat(titles.count)
            let labelH:CGFloat = frame.height - mScrollLineH;
            let labelX:CGFloat = labelW * CGFloat(index)
            let labelY:CGFloat = 0
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
            
            labels.append(label)
        }
    }
    
    
    fileprivate func initTitleBottomLineAndScrollLine(){
        //添加 底部线
        let bottomLineH:CGFloat = 0.5
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        bottomLine.frame = CGRect(x: 0, y: frame.height-bottomLineH, width: frame.width, height: bottomLineH)
        scrollView.addSubview(bottomLine)
        
        //添加 scrollLine
        let firstLabel = labels.first;
        firstLabel?.textColor = UIColor.orange
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: (firstLabel?.frame.origin.x)!, y: frame.height - mScrollLineH, width: (firstLabel?.frame.width)!, height: mScrollLineH)
        
    }
    
    
}
