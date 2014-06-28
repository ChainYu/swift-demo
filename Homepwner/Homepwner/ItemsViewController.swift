//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by chain on 14-6-24.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var headerView : UIView?
    
    @IBAction func toggleEditingMode(sender : AnyObject) {
      
        if self.tableView.editing {
            sender.setTitle("Edit", forState: UIControlState.Normal)
            self.tableView.editing = false
        } else {
            sender.setTitle("Done", forState: UIControlState.Normal)
            self.tableView.editing = true
        }
    }

    
    @IBAction func addNewItem(sender : AnyObject) {
        var newItem: BNRItem = BNRItemStore.instance.createItem()
        var lastRow: Int = BNRItemStore.instance.allItems.indexOfObject(newItem)!
        var ips: NSIndexPath = NSIndexPath(forRow: lastRow, inSection: 0)
        
        self.tableView.insertRowsAtIndexPaths(NSArray(object:ips), withRowAnimation: UITableViewRowAnimation.Top)
    }
    
    init() {
        //super.init(style: UITableViewStyle.Grouped)
        super.init(nibName: nil, bundle: nil)
        
        // load tableHeaderView
        if self.headerView == nil {
            NSBundle.mainBundle().loadNibNamed("HeaderView", owner: self, options: nil)
        }
        
        for i in 0..2 {
            BNRItemStore.instance.createItem()
        }
        //tableView.editing = true
        
    }
    /*
    convenience init(style: UITableViewStyle) {
        self.init()
    }
    
    convenience init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        self.init()
    }
    */
    
    override func tableView(tableView: UITableView!, viewForHeaderInSection section: Int) -> UIView! {
        return self.headerView
    }
    
    override  func tableView(tableView: UITableView!, heightForHeaderInSection section: Int) -> CGFloat {
        return self.headerView!.bounds.size.height
    }
    
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return BNRItemStore.instance.allItems.count
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("UITableViewCell") as? UITableViewCell
        
        if !cell {
            cell = UITableViewCell(style: UITableViewCellStyle.Default,
                                    reuseIdentifier: "UITableViewCell")
        }
        
        var item: BNRItem = BNRItemStore.instance.allItems[indexPath.row]
        cell!.textLabel.text = item.description()
        
        return cell!
    }

}
