//
//  PeripheralServiceCharacteristicValuesViewController.swift
//  BlueCap
//
//  Created by Troy Stribling on 7/5/14.
//  Copyright (c) 2014 gnos.us. All rights reserved.
//

import UIKit
import BlueCapKit

class PeripheralServiceCharacteristicValuesViewController : UITableViewController {
   
    var characteristic          : Characteristic?
    @IBOutlet var refreshButton :UIButton
    
    struct MainStoryboard {
        static let peripheralServiceCharactertisticValueCell  = "PeripheralServiceCharacteristicValueCell"
    }
    
    init(coder aDecoder:NSCoder!) {
        super.init(coder:aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let characteristic = self.characteristic {
            self.navigationItem.title = characteristic.name
            characteristic.read({
                    self.tableView.reloadData()
                },
                afterReadFailedCallback:{(error) in                    
                })
        }
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Bordered, target:nil, action:nil)
    }
    
    override func prepareForSegue(segue:UIStoryboardSegue!, sender:AnyObject!) {
    }
    
    @IBAction func updateValues() {
    }
    
    // UITableViewDataSource
    override func numberOfSectionsInTableView(tableView:UITableView!) -> Int {
        return 1
    }
    
    override func tableView(_:UITableView!, numberOfRowsInSection section:Int) -> Int {
        if let characteristic = self.characteristic {
            return characteristic.stringValue.count
        } else {
            return 0;
        }
    }
    
    override func tableView(tableView:UITableView!, cellForRowAtIndexPath indexPath:NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier(MainStoryboard.peripheralServiceCharactertisticValueCell, forIndexPath: indexPath) as PeripheralServiceCharacteristicValueCell
        if let characteristic = self.characteristic {
            let stringValues = characteristic.stringValue
            let names = Array(stringValues.keys)
            let values = Array(stringValues.values)
            cell.valueNameLabel.text = names[indexPath.row]
            cell.valueLable.text = values[indexPath.row]
        }
        return cell
    }
    
    // UITableViewDelegate
    
}
