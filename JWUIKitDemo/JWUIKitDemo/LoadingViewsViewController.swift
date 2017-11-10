//
//  LoadingViewsViewController.swift
//  JWUIKitDemo
//
//  Created by Jerry on 16/3/28.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

import UIKit

class LoadingViewsViewController: UIViewController, UICollectionViewDataSource {
    
    let cellIdentifier = "cellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "JWUIKitLoadingViews"
        
        let collectionViewFlowlayout = UICollectionViewFlowLayout()
        collectionViewFlowlayout.scrollDirection = .vertical
        collectionViewFlowlayout.minimumLineSpacing = 10
        collectionViewFlowlayout.minimumInteritemSpacing = 10
        collectionViewFlowlayout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10)
        collectionViewFlowlayout.itemSize = CGSize(width: 80, height: 80)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: collectionViewFlowlayout)
        collectionView.alwaysBounceVertical = true
        collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: cellIdentifier)
        collectionView.backgroundColor = UIColor(white: 240.0 / 255.0, alpha: 1.0)
        self.view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.dataSource = self
        
        let refreshBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(LoadingViewsViewController.reloadProgress))
        self.navigationItem.rightBarButtonItem = refreshBarButtonItem
    }
    
    @objc func reloadProgress() {
        let vc = UIViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundColor = UIColor(white: 220.0 / 255.0, alpha: 1.0)
        
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }
        
        var cellView :UIView?
        
        if (indexPath as NSIndexPath).row == 0 {
            let radarLoadingView = JWRadarLoadingView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            cellView = radarLoadingView;
        } else if (indexPath as NSIndexPath).row == 1 || (indexPath as NSIndexPath).row == 2 {
            let soundLikeLoadingView = JWBarLoadingView(frame: CGRect(x: 0, y: 0, width: 25, height: 20))
            if (indexPath as NSIndexPath).row == 2 {
                soundLikeLoadingView.style = .wave
                soundLikeLoadingView.duration = 0.2
            }
            cellView = soundLikeLoadingView
        } else if (indexPath as NSIndexPath).row == 3 || (indexPath as NSIndexPath).row == 4 || (indexPath as NSIndexPath).row == 5 {
            let circleLoadingView = JWCircleLoadingView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
            circleLoadingView.style = JWCircleLoadingStyle(rawValue: (indexPath as NSIndexPath).row - 3)!
            cellView = circleLoadingView
        } else if (indexPath as NSIndexPath).row == 6 || (indexPath as NSIndexPath).row == 7 {
            let lineStyle = (indexPath as NSIndexPath).row == 7
            let dotCircleLoadingView = JWDotLoadingView(frame: CGRect(x: 0, y: 0, width: lineStyle ? 80 : 30, height: 30))
            dotCircleLoadingView.style = lineStyle ? .line : .circle;
            cellView = dotCircleLoadingView
        }
        
        cell.tintColor = JWConst.themeColor
        cell.contentView.addSubview(cellView!)
        cellView!.center = CGPoint(x: cell.frame.width * 0.5, y: cell.frame.height * 0.5)
        
        (cellView as! JWLoadingProtocol).startAnimating()
        
        return cell
    }

}
