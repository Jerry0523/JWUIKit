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
    var refreshView: JWRefreshHeaderView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "JWUIKitToast"
        self.view.backgroundColor = JWConst.backgroundColor
        
        refreshView = JWRefreshHeaderView.headerWithRefreshingBlock {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(3 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
                [weak self] in
                if self != nil {
                    (self?.refreshView?.contentView as! JWRefreshContentViewProtocol).loadedSuccess!()
                    self?.refreshView?.endRefreshingWithDelay(1.0)
                }
            });
        }
        self.view.addSubview(refreshView!)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        refreshView?.startRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func didPressToastButton(sender: AnyObject) {
        self.view.endEditing(true)
        JWToast.makeToast(textField.text).show()
    }
}
