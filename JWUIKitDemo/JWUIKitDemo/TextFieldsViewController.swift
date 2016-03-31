//
//  TextFieldsViewController.swift
//  JWUIKitDemo
//
//  Created by Jerry on 16/3/18.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

import UIKit

class TextFieldsViewController: UIViewController {
    
    @IBOutlet weak var complexTextField: JWTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "JWUIKitTextFields"
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        self.view.addGestureRecognizer(tap)
        
        self.setupComplexTextField()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupComplexTextField() {
        let imageView = UIImageView(image: UIImage(named: "account"))
        
        let button = JWButton()
        button.titleLabel?.font = UIFont.systemFontOfSize(14)
        button.setTitle("Male", forState: .Normal)
        button.setTitleColor(UIColor(white: 0.5, alpha: 1.0), forState: .Normal)
        button.setImage(UIImage(named: "arrowDown"), forState: .Normal)
        button.imagePosition = .Right
        button.offset = 5.0;
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 2)
        button.sizeToFit()
        
        imageView.bounds = CGRectMake(0, 0, CGRectGetHeight(button.frame), CGRectGetHeight(button.frame))
        
        self.complexTextField.leftViews = [JWTextFieldSpaceView(), imageView, button]
    }

}
