//
//  ShapeViewsController.swift
//  JWUIKitDemo
//
//  Created by Jerry on 16/3/28.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

import UIKit

class ShapesViewController: UIViewController {

    @IBOutlet weak var textShape: JWTextShape!
    @IBOutlet weak var microphoneView: JWMicrophoneView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "JWUIKitShapeViews"
        self.fakeVolume()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textShape.duration = 3.0
        textShape.beginSimpleAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func fakeVolume() {
        let randomValue = CGFloat(JWRandom(1, 100)) / 100.0
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
            [weak self] in
            self?.microphoneView.volumn = randomValue
            if self != nil {
                self?.fakeVolume()
            }
        });
    }
}
