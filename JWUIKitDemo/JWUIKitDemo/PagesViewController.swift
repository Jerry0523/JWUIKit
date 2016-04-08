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
        
        let pageView = JWPageView(frame: CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 160))
        
        pageView.autoresizingMask = .FlexibleWidth
        pageView.delegate = self
        pageView.dataSource = self
        pageView.backgroundColor = UIColor.whiteColor()
        pageView.autoPlayInterval = 3.0;
        
        pageView.pageControl.activeImage = UIImage(named: "diamond")
        
        self.view.addSubview(pageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//MARK: - JWPageViewDataSource & JWPageViewDelegate
    func numberOfPagesInPageView(aPageView: JWPageView) -> UInt {
        return 4
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
}

