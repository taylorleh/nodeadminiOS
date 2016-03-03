//
//  ClientCredentials.swift
//  nodeadmin
//
//  Created by Taylor Lehman on 2/24/16.
//  Copyright © 2016 Taylor Lehman. All rights reserved.
//

import UIKit

class ClientCredentials {
  var host: String?
  var user: String?
  var password: String?
  
  let configString = "/nodeadmin/mobile/api/auth"
  let dbbaseurl = "/nodeadmin/mobile/api/db"
  
  var dblogin:String {
    get {
      return "\(self.host!+self.dbbaseurl)/\(self.user!)/\(self.password!)"
    }
  }
  
  var getDatabases: String {
    get {
      return "\(self.host!+self.dbbaseurl)"
    }
  }
  
  
  
  static let sharedInstance = ClientCredentials()

}
