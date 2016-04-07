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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = JWConst.backgroundColor
        self.automaticallyAdjustsScrollViewInsets = false
        
        let pageView = JWPageView(frame: CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 200))
        pageView.delegate = self
        pageView.dataSource = self
        pageView.backgroundColor = UIColor.whiteColor()
        
//        pageView.pageControl.inactiveImage = UIImage(named: "diamondEmpty")
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
            label.textColor = JWConst.textColor
            label.font = UIFont.systemFontOfSize(20.0)
            label.textAlignment = .Center
            mReusableView = label
        }
        let label: UILabel = mReusableView as! UILabel
        label.text = "Page \(aIndex)"
        return mReusableView!
    }
}

