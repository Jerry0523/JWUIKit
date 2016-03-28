//
//  LoadingViewsViewController.swift
//  JWUIKitDemo
//
//  Created by Jerry on 16/3/22.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

import UIKit

class ProgressViewsViewController: UIViewController {
    
    @IBOutlet weak var circleProgressView0: JWCircleProgressView!

    @IBOutlet weak var circleProgressView1: JWCircleProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "JWUIKitProgressViews"
        self.fakeProgress()
        
        let refreshBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: #selector(ProgressViewsViewController.reloadProgress))
        self.navigationItem.rightBarButtonItem = refreshBarButtonItem
    }
    
    func fakeProgress() {
        let randomValue = CGFloat(JWRandom(10, 20)) / 100.0
        circleProgressView0.progress += randomValue;
        circleProgressView1.progress += randomValue;
        
        if circleProgressView0.progress < 1.0 {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), {
                self .fakeProgress()
            });
        }
    }
    
    func reloadProgress() {
        if circleProgressView0.progress != 1.0 {
            return;
        }
        circleProgressView0.progress = 0;
        circleProgressView1.progress = 0;
        self.fakeProgress()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
