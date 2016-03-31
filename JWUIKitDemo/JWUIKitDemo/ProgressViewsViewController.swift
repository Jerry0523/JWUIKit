//
//  LoadingViewsViewController.swift
//  JWUIKitDemo
//
//  Created by Jerry on 16/3/22.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

import UIKit

class ProgressViewsViewController: UIViewController, UICollectionViewDataSource {
    
    let cellIdentifier = "cellIdentifier"
    
    let circleProgressView0 = JWCircleProgressView(frame:CGRectMake(0, 0, 30, 30))
    let circleProgressView1 = JWCircleProgressView(frame:CGRectMake(0, 0, 30, 30))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "JWUIKitProgressViews"
        
        let collectionViewFlowlayout = UICollectionViewFlowLayout()
        collectionViewFlowlayout.scrollDirection = .Vertical
        collectionViewFlowlayout.minimumLineSpacing = 10
        collectionViewFlowlayout.minimumInteritemSpacing = 10
        collectionViewFlowlayout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10)
        collectionViewFlowlayout.itemSize = CGSizeMake(80, 80)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: collectionViewFlowlayout)
        collectionView.alwaysBounceVertical = true
        collectionView.registerClass(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: cellIdentifier)
        collectionView.backgroundColor = UIColor(white: 240.0 / 255.0, alpha: 1.0)
        self.view.addSubview(collectionView)
        collectionView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        collectionView.dataSource = self
        
        let refreshBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: #selector(ProgressViewsViewController.reloadProgress))
        self.navigationItem.rightBarButtonItem = refreshBarButtonItem
        
        circleProgressView0.progress = 0
        circleProgressView1.progress = 0
        circleProgressView1.style = .Pie
        
        self.fakeProgress()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func fakeProgress() {
        let randomValue = CGFloat(JWRandom(10, 20)) / 100.0
        circleProgressView0.progress += randomValue;
        circleProgressView1.progress += randomValue;
        
        if circleProgressView0.progress < 1.0 {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), {
                [weak self] in
                self?.fakeProgress()
            });
        }
    }
    
    func reloadProgress() {
        if circleProgressView0.progress != 1.0 {
            return;
        }
        circleProgressView0.progress = 0;
        circleProgressView1.progress = 0;
        self.fakeProgress()
    }
    
    //MARK: - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.backgroundColor = UIColor(white: 220.0 / 255.0, alpha: 1.0)
        
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }
        var cellView :UIView?
        
        if indexPath.row == 0 {
            cellView = self.circleProgressView0
        } else if indexPath.row == 1 {
            cellView = self.circleProgressView1
        }
        
        let tintColor = UIColor(red: 249.0 / 255.0, green: 147.0 / 255.0, blue: 104.0 / 255.0, alpha: 1.0)
        cell.tintColor = tintColor
        cell.contentView.addSubview(cellView!)
        cellView!.center = CGPointMake(CGRectGetWidth(cell.frame) * 0.5, CGRectGetHeight(cell.frame) * 0.5)
        
        return cell
    }
}
