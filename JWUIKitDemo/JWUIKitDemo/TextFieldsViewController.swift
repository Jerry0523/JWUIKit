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
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitle("Male", for: UIControlState())
        button.setTitleColor(UIColor(white: 0.5, alpha: 1.0), for: UIControlState())
        button.setImage(UIImage(named: "arrowDown"), for: UIControlState())
        button.imagePosition = .right
        button.offset = 5.0;
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 2)
        button.sizeToFit()
        
        imageView.bounds = CGRect(x: 0, y: 0, width: button.frame.height, height: button.frame.height)
        
        self.complexTextField.leftViews = [JWTextFieldSpaceView(), imageView, button]
    }

}
