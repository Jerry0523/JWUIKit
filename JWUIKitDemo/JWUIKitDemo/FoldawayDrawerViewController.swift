//
//  FoldawayDrawerViewController.swift
//  JWUIKitDemo
//
//  Created by 王杰 on 16/4/15.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

import UIKit

class FoldawayDrawerViewController: UIViewController, JWFoldawayDrawerDataSource, JWFoldawayDrawerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet var section0View: UIView!
    @IBOutlet var section1View: UIView!
    @IBOutlet var section2View: UIView!
    
    lazy var drawerView :JWFoldawayDrawer = {
        let drawerView = JWFoldawayDrawer()
        drawerView.backgroundColor = UIColor.black
        drawerView.dataSource = self
        drawerView.delegate = self
        return drawerView
    }()
    
    let cellIdentifier = "cellIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "JWUIKitFoldawayDrawer"
        
        let tableView :UITableView = self.view as! UITableView
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
        tableView.estimatedRowHeight = 225
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - UITableViewDataSource & UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        if (indexPath as NSIndexPath).section == 0 {
            cell.textLabel?.text = "section0"
        } else if (indexPath as NSIndexPath).section == 1 {
            if cell.contentView.subviews.count == 0 {
                cell.contentView.addSubview(self.drawerView)
                cell.selectionStyle = .none
                
                let leftConstraint = NSLayoutConstraint(item: drawerView, attribute: .leading, relatedBy: .equal, toItem: cell.contentView, attribute: .leading, multiplier: 1.0, constant: 0)
                
                let rightConstraint = NSLayoutConstraint(item: drawerView, attribute: .trailing, relatedBy: .equal, toItem: cell.contentView, attribute: .trailing, multiplier: 1.0, constant: 0)
                
                
                let topConstraint = NSLayoutConstraint(item: drawerView, attribute: .top, relatedBy: .equal, toItem: cell.contentView, attribute: .top, multiplier: 1.0, constant: 0)
                
                let bottomConstraint = NSLayoutConstraint(item: drawerView, attribute: .bottom, relatedBy: .equal, toItem: cell.contentView, attribute: .bottom, multiplier: 1.0, constant: 0)
                
                leftConstraint.isActive = true
                rightConstraint.isActive = true
                topConstraint.isActive = true
                bottomConstraint.isActive = true
                
                drawerView.translatesAutoresizingMaskIntoConstraints = false
                
            }
        } else {
            cell.textLabel?.text = "section2"
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if (indexPath as NSIndexPath).section == 1 {
            drawerView.toggle()
        }
    }
    
    //MARK: - JWFoldawayDrawerDataSource
    
    func numberOfViews() -> UInt {
        return 3
    }
    
    func view(at index: UInt) -> UIView! {
        if index == 0 {
            return self.section0View
        } else if index == 1 {
            return self.section1View
        } else if index == 2 {
            return self.section2View
        }
        return nil
    }
}
