//
//  DatabaseTableViewController.swift
//  nodeadmin
//
//  Created by Taylor Lehman on 1/29/16.
//  Copyright © 2016 Taylor Lehman. All rights reserved.
//

import UIKit

protocol DatabaseCreateOperationProtocol {
  func shouldRequestUpdateFromServerAfterCreation(_:Bool) -> Void
}

class DatabaseTableViewController: UITableViewController, DatabaseCreateOperationProtocol {
  
  var clientDatabases: Array<String>?
  var createDBModalDelegate: DatabaseCreateOperationProtocol?
  
  let clientApi = ClientAPI()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationController?.setNavigationBarHidden(false, animated: true)
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    let dbCount = self.clientDatabases?.count ?? 0
    return dbCount
  }
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    // Configure the cell...
    let cell = tableView.dequeueReusableCellWithIdentifier("dbentity", forIndexPath: indexPath)
    cell.textLabel?.textColor = UIColor.grayColor()
    cell.contentView.backgroundColor = UIColor.blackColor()
    cell.backgroundColor = UIColor.blackColor()
  
    cell.textLabel?.text = self.clientDatabases![indexPath.row]

    return cell
  }
  
  func shouldRequestUpdateFromServerAfterCreation(success: Bool) {
    if success == true {
      self.presentedViewController?.dismissViewControllerAnimated(true, completion: nil)
      clientApi.getClientDatabases{ dbs -> Void in
        self.clientDatabases = dbs
      }
      tableView.reloadData()
      print("DID IT")
    } else {
      print("FAIL")
      self.presentedViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
  }
  
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if segue.identifier == "adddb" {
      let createdbvc = segue.destinationViewController as! AddDatabaseViewController
      createdbvc.delegate = self
    }
    
  }

  
  /*
  // Override to support conditional editing of the table view.
  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
  // Return false if you do not want the specified item to be editable.
  return true
  }
  */
  
  /*
  // Override to support editing the table view.
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
  if editingStyle == .Delete {
  // Delete the row from the data source
  tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
  } else if editingStyle == .Insert {
  // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
  }
  }
  */
  
  /*
  // Override to support rearranging the table view.
  override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
  
  }
  */
  
  /*
  // Override to support conditional rearranging of the table view.
  override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
  // Return false if you do not want the item to be re-orderable.
  return true
  }
  */
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
}
