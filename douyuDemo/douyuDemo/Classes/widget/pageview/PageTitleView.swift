//
//  PageTitleView.swift
//  douyuDemo
// 自定义pageTitle控件
//  Created by 田鹏升 on 2017/8/31.
//  Copyright © 2017年 田鹏升. All rights reserved.
//

import UIKit

class PageTitleView: UIView {
    fileprivate var currLabelIndex = 0;
    fileprivate var mScrollLineH:CGFloat = 2;
    internal weak var delegate:PageTitleViewDelegate?
    
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

protocol PageTitleViewDelegate : class{
    func pageTitleViewClick(selectedIndex index : Int)
    
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
        let labelW:CGFloat = frame.width / CGFloat(titles.count)
        let labelH:CGFloat = frame.height - mScrollLineH;
        let labelY:CGFloat = 0
        
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
            let labelX:CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //给label 添加点击事件 （添加手势）
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))  // (tapGes:) 可以省略
            label.addGestureRecognizer(tapGes)
            
            
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
        guard let firstLabel = labels.first else {return}
        firstLabel.textColor = UIColor.orange
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - mScrollLineH, width: firstLabel.frame.width, height: mScrollLineH)
        
    }
    
    
    
}

// MARK:- 对外暴露的方法
extension PageTitleView{
    internal func setTitleViewChange(progress:CGFloat,sourceIndex :Int,targetIndex:Int){
        
    }
}

// MARK:-  声明label点击事件
extension PageTitleView{
    
    //事件声明
    @objc fileprivate  func titleLabelClick(tapGes : UITapGestureRecognizer){
        //获取当前label
        guard let currLabel = tapGes.view as?UILabel else {return}
        
        //获取之前的label
        let oldLabel = labels[currLabelIndex]
        //赋值最新的 label index
        currLabelIndex = currLabel.tag
        
        // label 文字颜色 高亮
        currLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.black
        
        //底部指示器，滑动到选中的label位置
        let scrollLineNewX = CGFloat(currLabelIndex) * oldLabel.frame.width
        UIView.animate(withDuration: 0.5) {
            self.scrollLine.frame.origin.x = scrollLineNewX
        }
        
        //代理事件调用
        delegate?.pageTitleViewClick(selectedIndex: currLabelIndex)
    }
}








