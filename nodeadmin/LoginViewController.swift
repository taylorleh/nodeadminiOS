//
//  hostViewController.swift
//  nodeadmin
//
//  Created by Taylor Lehman on 1/26/16.
//  Copyright © 2016 Taylor Lehman. All rights reserved.
//

import UIKit
import Alamofire

protocol loginVCDelegate {
  func didValidateWithCredential(status:Bool)
}

class LoginViewController: UIViewController {
  
  @IBOutlet weak var hostName:UITextField?
  @IBOutlet weak var mySqlUser:UITextField?
  @IBOutlet weak var mySqlPassword:UITextField?
  
  @IBOutlet weak var connectionMessage: UITextField?
  
  
  var validConnection: Bool? = nil
  var delegate:loginVCDelegate?
  let clientInstance = ClientCredentials.sharedInstance
  let configString = "/nodeadmin/mobile/api/auth"
  let urlMatch = try? NSRegularExpression(pattern: "^http", options: .CaseInsensitive)
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func processError(code num: Int) {
    switch num {
    case 422:
      self.connectionMessage?.text = "wrong credentials"
      break
    case 500:
      self.connectionMessage?.text = "server failure"
      break
    case 400:
      self.connectionMessage?.text = "invalid url"
      break
    default:
      self.connectionMessage?.text = "error connecting to url"
      break
    }
    
  }
  
  @IBAction func connectToServer(sender: AnyObject) {
    guard let host = hostName, let user = mySqlUser, let pass = mySqlPassword
      where hostName?.text != nil && mySqlUser?.text != nil && mySqlPassword?.text != nil else {
        return
    }
    
    clientInstance.host = host.text
    clientInstance.user = user.text
    clientInstance.password = pass.text
    
    let validUrl: Int? = urlMatch?.numberOfMatchesInString(host.text!,
      options: .ReportProgress,
      range:NSRange.init(location:0, length: host.text!.characters.count))
    
    if validUrl < 1 {
      processError(code: 400)
      return
    }
    
    
    Alamofire.request(.GET, clientInstance.dblogin)
      .response { request, response, data, error in
        let statusCode = response?.statusCode
        
        if statusCode == 200 {
          self.validConnection = true
          self.delegate?.didValidateWithCredential(true)
        }
    }
    
  }
  
}
