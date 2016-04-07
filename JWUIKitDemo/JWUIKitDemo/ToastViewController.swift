//
//  ToastViewController.swift
//  JWUIKitDemo
//
//  Created by Jerry on 16/4/6.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

import UIKit

class ToastViewController: UIViewController {
    @IBOutlet weak var textField: JWTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "JWUIKitToast"
        self.view.backgroundColor = JWConst.backgroundColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func didPressToastButton(sender: AnyObject) {
        self.view.endEditing(true)
        JWToast.makeToast(textField.text).show()
    }
}
