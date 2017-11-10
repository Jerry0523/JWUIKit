//
//  MaskViewController.swift
//  JWUIKitDemo
//
//  Created by Jerry on 16/4/6.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

import UIKit

class MaskViewController: UIViewController {

    @IBOutlet weak var directionSegment: UISegmentedControl!
    
    @IBOutlet var topView: UIView!
    @IBOutlet var bottomView: UIView!
    @IBOutlet var sideView: UIView!
    
    @IBOutlet weak var drawShadowSwitch: UISwitch!
    @IBOutlet weak var modalSwitch: UISwitch!
    @IBOutlet weak var onWindowSwitch: UISwitch!
    
    lazy var drawer = JWMaskDrawer()
    
    lazy var cameraMask :JWCamaraMaskView = {
        let mask = JWCamaraMaskView()
        mask.tintColor = JWConst.themeColor
        return mask
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "JWUIKitMask"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func submitButtonClicked(_ sender: AnyObject) {
        drawer.dismiss(onCompletion: nil)
    }
    
    @IBAction func showCameraMask(_ sender: AnyObject) {
        self.cameraMask.frame = self.view.bounds
        self.cameraMask.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view .addSubview(self.cameraMask)
    }
    
    @IBAction func actionButtonClicked(_ sender: AnyObject) {
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
            if onWindowSwitch.isOn {
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
        
        drawer.direction = JWMaskDrawerDirection(rawValue:directionSegment.selectedSegmentIndex)!
        drawer.modal = modalSwitch.isOn
        drawer.drawShadow = drawShadowSwitch.isOn
        
        drawer.show(in: self.view, onWindow: onWindowSwitch.isOn, completion: nil)
    }
}
