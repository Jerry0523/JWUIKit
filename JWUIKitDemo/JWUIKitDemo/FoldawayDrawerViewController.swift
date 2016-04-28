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
        drawerView.backgroundColor = UIColor.blackColor()
        drawerView.dataSource = self
        drawerView.delegate = self
        return drawerView
    }()
    
    let cellIdentifier = "cellIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "JWUIKitFoldawayDrawer"
        
        let tableView :UITableView = self.view as! UITableView
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
        tableView.estimatedRowHeight = 225
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - UITableViewDataSource & UITableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "section0"
        } else if indexPath.section == 1 {
            if cell.contentView.subviews.count == 0 {
                cell.contentView.addSubview(self.drawerView)
                cell.selectionStyle = .None
                
                let leftConstraint = NSLayoutConstraint(item: drawerView, attribute: .Leading, relatedBy: .Equal, toItem: cell.contentView, attribute: .Leading, multiplier: 1.0, constant: 0)
                
                let rightConstraint = NSLayoutConstraint(item: drawerView, attribute: .Trailing, relatedBy: .Equal, toItem: cell.contentView, attribute: .Trailing, multiplier: 1.0, constant: 0)
                
                
                let topConstraint = NSLayoutConstraint(item: drawerView, attribute: .Top, relatedBy: .Equal, toItem: cell.contentView, attribute: .Top, multiplier: 1.0, constant: 0)
                
                let bottomConstraint = NSLayoutConstraint(item: drawerView, attribute: .Bottom, relatedBy: .Equal, toItem: cell.contentView, attribute: .Bottom, multiplier: 1.0, constant: 0)
                
                leftConstraint.active = true
                rightConstraint.active = true
                topConstraint.active = true
                bottomConstraint.active = true
                
                drawerView.translatesAutoresizingMaskIntoConstraints = false
                
            }
        } else {
            cell.textLabel?.text = "section2"
        }
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15.0
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 1 {
            drawerView.toggle()
        }
    }
    
    //MARK: - JWFoldawayDrawerDataSource
    
    func numberOfViews() -> UInt {
        return 3
    }
    
    func viewAtIndex(index: UInt) -> UIView! {
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
