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
    let data = [["name":"Label", "class":LabelsViewController.self],
                ["name":"TextField", "class":TextFieldsViewController.self],
                ["name":"Button", "class":ButtonsViewController.self],
                ["name":"Loading", "class":LoadingViewsViewController.self],
                ["name":"Progress", "class":ProgressViewsViewController.self],
                ["name":"Shape", "class":ShapesViewController.self],
                ["name":"Mask", "class":MaskViewController.self],
                ["name":"Toast", "class":ToastViewController.self],
                ["name":"Page", "class":PagesViewController.self],
                ["name":"Drawer", "class":FoldawayDrawerViewController.self],
               ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleView = JWButton()
        titleView.isUserInteractionEnabled = false
        titleView.setTitle("JWUIKitDemo", for: .normal)
        titleView.setImageName("logo", for: .normal)
        titleView.setTitleColor(UIColor.white, for: .normal)
        titleView.contentEdgeInsets = UIEdgeInsetsMake(2, 5, 2, 5)
        titleView .sizeToFit()
        
        self.navigationItem.titleView = titleView
        
        let padding = CGFloat(JWConvertValue(10, 375, Float(self.view.frame.width)))
        let itemSize = CGFloat(JWConvertValue(80, 375, Float(self.view.frame.width)))
        
        let collectionViewFlowlayout = UICollectionViewFlowLayout()
        collectionViewFlowlayout.scrollDirection = .vertical
        collectionViewFlowlayout.minimumLineSpacing = padding
        collectionViewFlowlayout.minimumInteritemSpacing = padding
        collectionViewFlowlayout.sectionInset = UIEdgeInsetsMake(padding, padding, 0, padding)
        
        collectionViewFlowlayout.itemSize = CGSize(width: itemSize, height: itemSize)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: collectionViewFlowlayout)
        collectionView.alwaysBounceVertical = true
        collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: cellIdentifier)
        collectionView.backgroundColor = UIColor(white: 240.0 / 255.0, alpha: 1.0)
        self.view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.barStyle = .black;
        self.navigationController!.navigationBar.barTintColor = JWConst.themeColor;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController!.navigationBar.barStyle = .default;
        self.navigationController!.navigationBar.barTintColor = nil;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundColor = UIColor(white: 220.0 / 255.0, alpha: 1.0)
        
        if cell.contentView.subviews.count == 0 {
            let label = UILabel(frame: cell.bounds)
            label.textColor = JWConst.textColor
            label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            label.font = UIFont.systemFont(ofSize: 15.0)
            label.textAlignment = .center
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            cell.contentView.addSubview(label)
        }
        
        let label: UILabel = cell.contentView.subviews[0] as! UILabel
        let item = data[(indexPath as NSIndexPath).row]
        label.text = item["name"] as? String
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mClass: UIViewController.Type? = data[(indexPath as NSIndexPath).row]["class"] as? UIViewController.Type
        if mClass != nil {
            let vc = mClass!.self.init();
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
