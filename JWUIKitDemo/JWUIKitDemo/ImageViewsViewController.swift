//
//  ImageViewsViewController.swift
//  JWUIKitDemo
//
//  Created by 王杰 on 16/3/19.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

import UIKit

class ImageViewsViewController: UIViewController, UICollectionViewDataSource {
    
    let cellIdentifier = "cellIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "JWUIKitImageViews"
        
        let collectionViewFlowlayout = UICollectionViewFlowLayout()
        collectionViewFlowlayout.scrollDirection = .Vertical
        collectionViewFlowlayout.minimumLineSpacing = 20
        collectionViewFlowlayout.minimumInteritemSpacing = 20
        collectionViewFlowlayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20)
        let cellWidth = (CGRectGetWidth(self.view.frame) - 20 * 3) * 0.5
        collectionViewFlowlayout.itemSize = CGSizeMake(cellWidth, cellWidth)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: collectionViewFlowlayout)
        collectionView.alwaysBounceVertical = true
        collectionView.registerClass(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: cellIdentifier)
        collectionView.backgroundColor = UIColor(white: 240.0 / 255.0, alpha: 1.0)
        self.view.addSubview(collectionView)
        collectionView.dataSource = self
        
        let refreshBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Refresh, target: collectionView, action: "reloadData")
        self.navigationItem.rightBarButtonItem = refreshBarButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath)
        if cell.contentView.subviews.count == 0 {
            let jwImageView = JWAnimatedImageView(frame: cell.contentView.bounds)
            cell.contentView.addSubview(jwImageView)
        }
        
        let jwImageView:JWAnimatedImageView = cell.contentView.subviews[0] as! JWAnimatedImageView
        let animationType = JWAnimatedImageViewAnimation(rawValue: UInt(indexPath.row))
        jwImageView.animationStyle = animationType!
        jwImageView.image = UIImage(named: "flow0")
        
        return cell
    }

}
