//
//  WidgetsListViewController.swift
//  JWUIKitDemo
//
//  Created by Jerry on 16/3/17.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

import UIKit

class WidgetsListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let cellIdentifier = "cellIdentifier"
    let data = [["name":"Label", "class":LabelsViewController.classForCoder()],
                ["name":"TextField", "class":TextFieldsViewController.classForCoder()],
                ["name":"Button", "class":ButtonsViewController.classForCoder()],
                ["name":"Image", "class":ImageViewsViewController.classForCoder()],
                ["name":"Loading", "class":LoadingViewsViewController.classForCoder()],
                ["name":"Progress", "class":ProgressViewsViewController.classForCoder()],
                ["name":"Shape", "class":ShapesViewController.classForCoder()],
                ["name":"Drawer", "class":DrawersViewController.classForCoder()],
                ["name":"Toast", "class":ToastViewController.classForCoder()],
                ["name":"Page", "class":PagesViewController.classForCoder()]
               ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleView = JWButton()
        titleView.userInteractionEnabled = false
        titleView.setTitle("JWUIKitDemo", forState: .Normal)
        titleView.setImageName("logo", forState: .Normal)
        titleView.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        titleView.contentEdgeInsets = UIEdgeInsetsMake(2, 5, 2, 5)
        titleView .sizeToFit()
        
        self.navigationItem.titleView = titleView
        
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
        collectionView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.barStyle = .Black;
        self.navigationController!.navigationBar.barTintColor = JWConst.themeColor;
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController!.navigationBar.barStyle = .Default;
        self.navigationController!.navigationBar.barTintColor = nil;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.backgroundColor = UIColor(white: 220.0 / 255.0, alpha: 1.0)
        
        if cell.contentView.subviews.count == 0 {
            let label = UILabel(frame: cell.bounds)
            label.textColor = JWConst.textColor
            label.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            label.font = UIFont.systemFontOfSize(15.0)
            label.textAlignment = .Center
            cell.contentView.addSubview(label)
        }
        
        let label: UILabel = cell.contentView.subviews[0] as! UILabel
        let item = data[indexPath.row]
        label.text = item["name"] as? String
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let mClass: UIViewController.Type? = data[indexPath.row]["class"] as? UIViewController.Type
        if mClass != nil {
            let vc = mClass!.self.init();
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
