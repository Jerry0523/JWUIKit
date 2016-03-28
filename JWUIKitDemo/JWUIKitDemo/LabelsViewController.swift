//
//  LabelsViewController.swift
//  JWUIKitDemo
//
//  Created by Jerry on 16/3/17.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

import UIKit

class LabelsViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "JWUIKitLabels"
        
        let refreshBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: #selector(LabelsViewController.didRefreshAnimation(_:)))
        self.navigationItem.rightBarButtonItem = refreshBarButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Actions
    func didRefreshAnimation(sender: UIBarButtonItem) {
        (self.contentView.subviews as NSArray).enumerateObjectsUsingBlock { (subView: AnyObject, index: Int, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
            if subView.respondsToSelector(#selector(JWTickNumberLabel.reloadData)) {
                subView.performSelector(#selector(JWTickNumberLabel.reloadData))
            }
        }
    }
}
