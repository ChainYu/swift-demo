//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by chain on 14-6-24.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController,
                            UITableViewDelegate, UITableViewDataSource {
    

    @IBAction func addNewItem(sender : AnyObject) {
        
        var newItem: BNRItem = BNRItemStore.instance.createItem()
        var detailViewController: DetailViewController = DetailViewController(forNewItem: true)
        detailViewController.item = newItem
        detailViewController.tableViewDataReloadHandler = tableViewReloadCallBack
        var naviViewController: UINavigationController = UINavigationController(rootViewController: detailViewController)
        naviViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(naviViewController, animated: true, completion: nil)
    }

    init() {
        
        super.init(nibName: nil, bundle: nil)
        
        self.navigationItem.title = "Homepwner"
        
        var barButtonItem: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add,
            target: self, action: "addNewItem:")
        self.navigationItem.rightBarButtonItem = barButtonItem
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
    }
    
    func tableViewReloadCallBack() {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MUST regist nib in viewDidLoad()
        var nib: UINib = UINib(nibName: "HomepwnerItemCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "HomepwnerItemCell")
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        var detailViewController: DetailViewController = DetailViewController(forNewItem: false)
        
        var selectedItem: BNRItem = BNRItemStore.instance.allItems[indexPath.row]
        detailViewController.item = selectedItem
        
        self.navigationController.pushViewController(detailViewController, animated: true)
    }
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return BNRItemStore.instance.allItems.count
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        var p: BNRItem = BNRItemStore.instance.allItems[indexPath.row]
        var cell: HomepwnerItemCell = tableView.dequeueReusableCellWithIdentifier("HomepwnerItemCell") as HomepwnerItemCell
        
        cell.nameLabel.text = p.itemName
        cell.serialNumberLabel.text = p.serialNumber
        cell.valueLabel.text = String(p.valueInDollars)
        cell.thumbnailView.image = p.thumbnail
        
        return cell
    }
    
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            BNRItemStore.instance.allItems.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths(NSArray(object: indexPath), withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    override  func tableView(tableView: UITableView!, moveRowAtIndexPath sourceIndexPath: NSIndexPath!, toIndexPath destinationIndexPath: NSIndexPath!) {
        
        BNRItemStore.instance.moveItemAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
        
    }
    
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        if indexPath.row ==  BNRItemStore.instance.allItems.count {
            return false
        }
        return true
    }

    override func tableView(tableView: UITableView!, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath!) -> String! {
        return "删除"
    }

}
