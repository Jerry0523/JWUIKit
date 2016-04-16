//
//  FoldawayDrawerViewController.swift
//  JWUIKitDemo
//
//  Created by 王杰 on 16/4/15.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

import UIKit

class FoldawayDrawerViewController: UIViewController, JWFoldawayDrawerDataSource, JWFoldawayDrawerDelegate {
    
    @IBOutlet weak var drawerView: JWFoldawayDrawer!
    
    @IBOutlet var section0View: UIView!
    @IBOutlet var section1View: UIView!
    @IBOutlet var section2View: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "JWUIKitFoldawayDrawer"
        self.drawerView.dataSource = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.drawerView.open()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - JWFoldawayDrawerDataSource
    
    func numberOfViews() -> UInt {
        return 3
    }
    
    func viewAtIndex(index: UInt) -> UIView! {
        if index == 0 {
            return self.section0View
        } else if index == 1 {
            return self.section1View
        } else if index == 2 {
            return self.section2View
        }
        return nil
    }
}
