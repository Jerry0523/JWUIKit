//
//  LoadingViewsViewController.swift
//  JWUIKitDemo
//
//  Created by Jerry on 16/3/22.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

import UIKit

class LoadingViewsViewController: UIViewController {
    
    let circleProgressView = JWCircleProgressView(frame: CGRectMake(0, 0, 40, 40))
    let circleProgressView1 = JWCircleProgressView(frame: CGRectMake(0, 0, 40, 40))

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "JWUIKitLoadingViews"
        
        self.view.backgroundColor = UIColor.blackColor()
        
        circleProgressView.center = CGPointMake(120, 200)
        self.view.addSubview(circleProgressView)
        
        circleProgressView.progress = 0
        circleProgressView.style = .Pie
        
        circleProgressView1.center = CGPointMake(120, 300)
        self.view.addSubview(circleProgressView1)
        
        circleProgressView1.progress = 0
        circleProgressView1.style = .Default
        
        let tap = UITapGestureRecognizer(target: self, action: "dealWithTap")
        self.view.addGestureRecognizer(tap)
    }
    
    func dealWithTap(){
        circleProgressView.progress += 0.3;
        circleProgressView1.progress += 0.3;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
