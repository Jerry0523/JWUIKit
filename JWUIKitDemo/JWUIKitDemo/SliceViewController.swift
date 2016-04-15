//
//  SliceViewController.swift
//  JWUIKitDemo
//
//  Created by Jerry on 16/4/15.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

import UIKit

class SliceCollectionViewCell: UICollectionViewCell {
    <#code#>
}

class SliceViewController: UIViewController {
    
    
    @IBOutlet weak var slice0View: UIView!
    
    @IBOutlet weak var slice1View: UIView!
    
    @IBOutlet weak var slice2View: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        slice0View.layer.borderWidth = 0.5
        slice1View.layer.borderWidth = 0.5
        slice2View.layer.borderWidth = 0.5
        
        let borderColor = UIColor(white: 230.0 / 255.0, alpha:1.0).CGColor
        slice0View.layer.borderColor = borderColor
        slice1View.layer.borderColor = borderColor
        slice2View.layer.borderColor = borderColor
        
        slice1View.alpha = 0;
        slice1View.layer.anchorPoint = CGPointMake(0.5, 0)
        
        
        
        slice1View.layer.transform = CATransform3DRotate(CATransform3DMakeTranslation(0, 0, 100), CGFloat(M_PI), 1, 0, 0)
        
        slice2View.alpha = 0
        slice2View.layer.anchorPoint = CGPointMake(0.5, 0)
        slice2View.layer.transform = CATransform3DRotate(CATransform3DMakeTranslation(0, 0, 100), CGFloat(M_PI), 1, 0, 0)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let duration = 0.6
        
        let currentMediaTime = CACurrentMediaTime();
        let animation = CABasicAnimation(keyPath: "transform")
        animation.fromValue = NSValue(CATransform3D: slice1View.layer.transform)
        animation.toValue = NSValue(CATransform3D: CATransform3DIdentity)
        animation.duration = duration
        animation.fillMode = kCAFillModeForwards
        animation.removedOnCompletion = false
        
        let fadeAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.fromValue = 0.8
        fadeAnimation.toValue = 1
        fadeAnimation.duration = duration
        fadeAnimation.fillMode = kCAFillModeForwards
        fadeAnimation.removedOnCompletion = false
        
        self.slice1View.layer.addAnimation(animation, forKey: nil)
        self.slice1View.layer.addAnimation(fadeAnimation, forKey: nil)
        
        
        animation.beginTime = currentMediaTime + duration
        animation.fromValue = NSValue(CATransform3D: slice2View.layer.transform)
        self.slice2View.layer.addAnimation(animation, forKey: nil)
        
        fadeAnimation.beginTime = currentMediaTime + duration
        self.slice2View.layer.addAnimation(fadeAnimation, forKey: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
