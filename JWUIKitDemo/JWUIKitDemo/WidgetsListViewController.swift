//
//  WidgetsListViewController.swift
//  JWUIKitDemo
//
//  Created by Jerry on 16/3/17.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

import UIKit

class WidgetsListViewController: UITableViewController {
    
    let cellIdentifier = "cellIdentifier"
    let data = [["name":"Label", "class":LabelsViewController.classForCoder()],
                ["name":"TextField", "class":TextFieldsViewController.classForCoder()],
                ["name":"Button", "class":ButtonsViewController.classForCoder()],
                ["name":"Image", "class":ImageViewsViewController.classForCoder()],
                ["name":"Loading", "class":LoadingViewsViewController.classForCoder()],
                ["name":"Progress", "class":ProgressViewsViewController.classForCoder()],
                ["name":"Shape", "class":ShapesViewController.classForCoder()],
                ["name":"Drawer", "class":DrawersViewController.classForCoder()]
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
        
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
        self.tableView.tableFooterView = UIView()
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

    // MARK: - UITableViewDataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        let item = data[indexPath.row]
        cell.textLabel?.textColor = JWConst.textColor
        cell.textLabel?.text = item["name"] as? String
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let mClass: UIViewController.Type? = data[indexPath.row]["class"] as? UIViewController.Type
        if mClass != nil {
            let vc = mClass!.self.init();
            self.navigationController?.pushViewController(vc, animated: true)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}
