//
//  PagesViewController.swift
//  JWUIKitDemo
//
//  Created by Jerry on 16/3/17.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

import UIKit

class PagesViewController: UIViewController, JWPageViewDataSource, JWPageViewDelegate{
    
//MARK: - LifeCycle
    override func loadView() {
        let scrollView = UIScrollView(frame: UIScreen.mainScreen().bounds)
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = JWConst.backgroundColor
        
        self.view = scrollView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = JWConst.backgroundColor
        self.title = "JWUIKitPage"
        
        self.view.addSubview(self.pageView)
        self.view.addSubview(self.textPageControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textPageControlValueDidChanged() {
        self.pageView.selectedIdx = self.textPageControl.selectedIdx
    }
    
//MARK: - JWPageViewDataSource & JWPageViewDelegate
    func numberOfPagesInPageView(aPageView: JWPageView) -> UInt {
        return 16
    }
    
    func pageView(aPageView: JWPageView, viewAt aIndex: UInt, reusableView: UIView?) -> UIView{
        var mReusableView = reusableView
        if (mReusableView == nil) {
            let label = UILabel()
            label.textColor = UIColor.whiteColor()
            label.font = UIFont.systemFontOfSize(20.0)
            label.textAlignment = .Center
            mReusableView = label
        }
        let label: UILabel = mReusableView as! UILabel
        label.backgroundColor = UIColor(hue: CGFloat(arc4random() % 256) / 256.0, saturation: CGFloat(arc4random() % 128) / 256.0 + 0.5, brightness: CGFloat(arc4random() % 128) / 256.0 + 0.5, alpha: 1.0)
        
        label.text = "Page \(aIndex)"
        return mReusableView!
    }
    
    func pageView(pageView: JWPageView, didScrollToIndex aIndex: UInt) {
        self.textPageControl.selectedIdx = Int(aIndex);
    }
    
//MARK: - Lazy Initialize
    lazy var pageView: JWPageView = {
        let pageView = JWPageView(frame: CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 160))
        
        pageView.autoresizingMask = .FlexibleWidth
        pageView.delegate = self
        pageView.dataSource = self
        pageView.backgroundColor = UIColor.whiteColor()
        pageView.autoPlayInterval = 3.0;
        
        pageView.pageControl.activeImage = UIImage(named: "diamond")
        return pageView
    }()
    
    lazy var textPageControl: JWTextPageControl = {
        let textPageControl = JWTextPageControl(frame: CGRectMake(0, 160, CGRectGetWidth(self.view.frame), 44))
        textPageControl.autoresizingMask = .FlexibleWidth
        textPageControl.selectionStyle = .Zoom
        textPageControl.contents = ["首页", "分类", "购物车", "账户","首页", "分类", "购物车", "账户", "首页", "分类", "购物车", "账户", "首页", "分类", "购物车", "账户"]
        textPageControl.tintColor = JWConst.themeColor
        textPageControl.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        
        textPageControl.addTarget(self, action: #selector(PagesViewController.textPageControlValueDidChanged), forControlEvents:.ValueChanged)
        
        return textPageControl
    }()
}

