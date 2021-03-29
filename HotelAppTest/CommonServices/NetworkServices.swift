//
//  NetworkServices.swift
//  HotelAppTest
//
//  Created by Admin on 3/29/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ReachabilitySwift

class NetworkServices{
    
    var reachability: Reachability = Reachability.init()!
    let connected: Bool = Reachability.init()!.isReachable
   

    func getRequestNetworkCallWithCodable(url : String, headers : [String: String], completionHandler: @escaping (Data? , Error?) -> ()) {
        
       Alamofire.request(url, method: .get, parameters: nil, encoding:URLEncoding.default, headers: headers).responseJSON{ response in
            
            
            
            switch response.result {
                
            case .success( _):
                
                completionHandler(response.data! , nil)
                
                
            case .failure(let error):
                
                completionHandler(nil, error)
                    
                
        }
        
        }
        
    }
    
     func ShowFailiureAlert(title: String, message: String, in vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }

}
