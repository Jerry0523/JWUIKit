//
//  ViewController.swift
//  JWUIKitDemo
//
//  Created by Jerry on 16/3/17.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, JWPageViewDataSource, JWPageViewDelegate{
    
//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let pageView = JWPageView(frame: CGRectMake(0, 20, CGRectGetWidth(self.view.frame), 200))
        pageView.delegate = self
        pageView.dataSource = self
        pageView.backgroundColor = UIColor.redColor()
        self.view.addSubview(pageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let label: UILabel = reusableView as! UILabel
        label.text = "第\(aIndex)个页面"
        return reusableView!
    }
}

