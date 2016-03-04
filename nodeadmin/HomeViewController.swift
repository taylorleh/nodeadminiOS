//
//  ViewController.swift
//  nodeadmin
//
//  Created by Taylor Lehman on 1/26/16.
//  Copyright © 2016 Taylor Lehman. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController, loginVCDelegate {
  
  
  let configString = "/nodeadmin/mobile/api/auth"
  let dbbaseurl = "/nodeadmin/mobile/api/db"
  let clientCredentials = ClientCredentials.sharedInstance
  let clientApi = ClientAPI()
  
  var response: NSURLResponse?
  internal var showDatabaseVC = false
  
//  MARK: ViewController methods
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
//  MARK: REST API
  
  
  // retreive client databases
  func getClientDatabases(callback:(Array<AnyObject>) -> Void) {
    
    Alamofire.request(.GET, "\(self.clientCredentials.host!+self.dbbaseurl)").response { request, response, data, error in
      if error == nil && data != nil {
        let dbs = try? NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! Array<AnyObject>
        callback(dbs!)
      }
    }
    
  }
  
  
  func didValidateWithCredential(status: Bool) {
    self.showDatabaseVC = status
    
    //    opens database controller if server acknowledges credentials
    if self.showDatabaseVC == true {
      self.presentedViewController?.dismissViewControllerAnimated(true, completion: nil)
      self.performSegueWithIdentifier("dbviewseque", sender: self)
    }
  }
  
  
  //  MARK: Segue Methods
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    //    login view
    if segue.identifier == "setupseque" {
      let vc = segue.destinationViewController as! LoginViewController
      vc.delegate = self
      
    }
    
    //    Database view
    if segue.identifier == "dbviewseque" {
      clientApi.getClientDatabases { data in
        let destination = segue.destinationViewController as! DatabaseTableViewController
        destination.clientDatabases = data
        
      }
    }
  }
  
  
  override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
    return true
  }
  
  
}

