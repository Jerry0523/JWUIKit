//
//  DrawersViewController.swift
//  JWUIKitDemo
//
//  Created by Jerry on 16/4/6.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

import UIKit

class DrawersViewController: UIViewController {

    @IBOutlet weak var directionSegment: UISegmentedControl!
    
    @IBOutlet var topView: UIView!
    @IBOutlet var bottomView: UIView!
    @IBOutlet var sideView: UIView!
    
    @IBOutlet weak var drawShadowSwitch: UISwitch!
    @IBOutlet weak var modalSwitch: UISwitch!
    @IBOutlet weak var onWindowSwitch: UISwitch!
    
    let drawer = JWDrawer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "JWUIKitDrawerViews"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func submitButtonClicked(sender: AnyObject) {
        drawer.dismissOnCompletion(nil)
    }
    
    @IBAction func actionButtonClicked(sender: AnyObject) {
        switch directionSegment.selectedSegmentIndex {
        case 0:
            drawer.contentView = self.bottomView
            break
        case 1:
            drawer.contentView = self.sideView
            break
        case 3:
            drawer.contentView = self.sideView
            break
        case 2:
            var rect = self.topView.frame
            if onWindowSwitch.on {
                rect.size.height = 155
            } else {
                rect.size.height = 200
            }
            self.topView.frame = rect
            drawer.contentView = self.topView
            break
        default:
            break
        }
        
        drawer.direction = JWDrawerDirection(rawValue:directionSegment.selectedSegmentIndex)!
        drawer.modal = modalSwitch.on
        drawer.drawShadow = drawShadowSwitch.on
        
        drawer.showInView(self.view, onWindow: onWindowSwitch.on, completion: nil)
    }
}
