//
//  LoadingViewsViewController.swift
//  JWUIKitDemo
//
//  Created by Jerry on 16/3/28.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

import UIKit

class LoadingViewsViewController: UIViewController {

    @IBOutlet weak var radarLoadingView: JWRadarLoadingView!
    @IBOutlet weak var soundLikeLoadingView: JWSoundLikeLoadingView!
    @IBOutlet weak var circleLoadingView: JWCircleLoadingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "JWUIKitLoadingViews"
    }
    
    override func viewDidAppear(animated: Bool) {
        radarLoadingView.startAnimating()
        soundLikeLoadingView.startAnimating()
        circleLoadingView.startAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
