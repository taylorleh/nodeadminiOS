//
//  ClientAPI.swift
//  nodeadmin
//
//  Created by Taylor Lehman on 2/24/16.
//  Copyright © 2016 Taylor Lehman. All rights reserved.
//

import UIKit
import Alamofire

class ClientAPI {
  
  func getClientDatabases(callback: (Array<String>) -> Void )  {
    let clientCredentials = ClientCredentials.sharedInstance
    
    Alamofire.request(.GET, clientCredentials.getDatabases).response {
      request, response, data, error in
      
      if error == nil && data != nil {
        var clientDatabases = Array<String>()
        let json_response = try? NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! [Dictionary<String,String>]
        
        
        clientDatabases = json_response!.flatMap { $0.values.first }
        
        callback(clientDatabases)
      }
    }
  }

}
