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
        
        let refreshBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(LabelsViewController.didRefreshAnimation(_:)))
        self.navigationItem.rightBarButtonItem = refreshBarButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Actions
    @objc func didRefreshAnimation(_ sender: UIBarButtonItem) {
        for subView in self.contentView.subviews {
            if subView.responds(to: #selector(JWTickNumberLabel.startAnimating)) {
                subView.perform(#selector(JWTickNumberLabel.startAnimating))
            }
        }
    }
}
