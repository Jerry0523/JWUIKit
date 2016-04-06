//
//  ToastViewController.swift
//  JWUIKitDemo
//
//  Created by Jerry on 16/4/6.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

import UIKit

class ToastViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "JWUIKitToast"
        self.view.backgroundColor = JWConst.backgroundColor
        
        JWToast.makeToast("Just a test sdjfksdjfklsdjklfsjdklfjskldjfklsdjflkjsdklfjsdklfjskldf").show()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
