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
                ["name":"Image", "class":LabelsViewController.classForCoder()]
               ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "JWUIKitDemo";
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
        self.tableView.tableFooterView = UIView()
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
