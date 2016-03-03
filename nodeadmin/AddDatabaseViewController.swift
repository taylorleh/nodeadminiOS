//
//  AddDatabaseViewController.swift
//  nodeadmin
//
//  Created by Taylor Lehman on 2/19/16.
//  Copyright © 2016 Taylor Lehman. All rights reserved.
//

import UIKit

class AddDatabaseViewController: UIViewController {
  
  @IBOutlet weak var databaseName: UITextField?
  
  var delegate: DatabaseCreateOperationProtocol?
  let createDatabaseURL = "/nodeadmin/mobile/api/db/create"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func makePostToServerWithNewDatabase(callback: Bool -> Void) {
    guard let dbname = databaseName where self.databaseName?.text != nil else {
        return
    }
    
    
    let urlPath = "http://localhost:4040\(self.createDatabaseURL)/\(dbname.text!)"
    let url = NSURL(string: urlPath)
    
    let request = NSMutableURLRequest(URL: url!)
    request.HTTPMethod = "POST"
    
    let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
      
      if error == nil {
        let body = response as! NSHTTPURLResponse
        if body.statusCode == 201 {
          callback(true)
        } else {
          callback(false)
        }
      } else {
        callback(false)
      }
    }
    task.resume()
  }
  
  @IBAction func didClickAddDatabase(sender:AnyObject?) {
    
    if self.databaseName?.text != "" {
      
      self.makePostToServerWithNewDatabase{
        (success) -> Void in
        if success == true {
          self.delegate?.shouldRequestUpdateFromServerAfterCreation(true)
        }
      }
    }
  }
  
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
}
