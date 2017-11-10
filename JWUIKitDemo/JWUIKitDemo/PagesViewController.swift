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
        let scrollView = UIScrollView(frame: UIScreen.main.bounds)
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
    
    @objc func textPageControlValueDidChanged() {
        self.pageView.selectedIdx = self.textPageControl.selectedIdx
    }
    
//MARK: - JWPageViewDataSource & JWPageViewDelegate
    func numberOfPages(in aPageView: JWPageView) -> UInt {
        return 16
    }
    
    func pageView(_ aPageView: JWPageView, viewAt aIndex: UInt, reusableView: UIView?) -> UIView{
        var mReusableView = reusableView
        if (mReusableView == nil) {
            let label = UILabel()
            label.textColor = UIColor.white
            label.font = UIFont.systemFont(ofSize: 20.0)
            label.textAlignment = .center
            mReusableView = label
        }
        let label: UILabel = mReusableView as! UILabel
        label.backgroundColor = UIColor(hue: CGFloat(arc4random() % 256) / 256.0, saturation: CGFloat(arc4random() % 128) / 256.0 + 0.5, brightness: CGFloat(arc4random() % 128) / 256.0 + 0.5, alpha: 1.0)
        
        label.text = "Page \(aIndex)"
        return mReusableView!
    }
    
    func pageView(_ pageView: JWPageView, didScrollTo aIndex: UInt) {
        self.textPageControl.selectedIdx = Int(aIndex);
    }
    
//MARK: - Lazy Initialize
    lazy var pageView: JWPageView = {
        let pageView = JWPageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 160))
        
        pageView.autoresizingMask = .flexibleWidth
        pageView.delegate = self
        pageView.dataSource = self
        pageView.backgroundColor = UIColor.white
        pageView.autoPlayInterval = 3.0;
        
        pageView.pageControl.activeImage = UIImage(named: "diamond")
        return pageView
    }()
    
    lazy var textPageControl: JWTextPageControl = {
        let textPageControl = JWTextPageControl(frame: CGRect(x: 0, y: 160, width: self.view.frame.width, height: 44))
        textPageControl.autoresizingMask = .flexibleWidth
        textPageControl.selectionStyle = .zoom
        textPageControl.contents = ["首页", "分类", "购物车", "账户","首页", "分类", "购物车", "账户", "首页", "分类", "购物车", "账户", "首页", "分类", "购物车", "账户"]
        textPageControl.tintColor = JWConst.themeColor
        textPageControl.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        
        textPageControl.addTarget(self, action: #selector(PagesViewController.textPageControlValueDidChanged), for:.valueChanged)
        
        return textPageControl
    }()
}

