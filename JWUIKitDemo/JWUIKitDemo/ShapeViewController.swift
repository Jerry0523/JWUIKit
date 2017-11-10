//
//  ShapeViewsController.swift
//  JWUIKitDemo
//
//  Created by Jerry on 16/3/28.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

import UIKit

class ShapesViewController: UIViewController {

    @IBOutlet weak var microphoneView: JWMicrophoneView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "JWUIKitShapeViews"
        self.fakeVolume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func fakeVolume() {
        let randomValue = CGFloat(JWRandom(1, 100)) / 100.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
            [weak self] in
            self?.microphoneView.volumn = randomValue
            if self != nil {
                self?.fakeVolume()
            }
        });
    }
}
