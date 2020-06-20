//
//  API_Manager.swift
//  Employee Record
//
//  Created by user on 20/06/20.
//  Copyright © 2020 user. All rights reserved.
//

import Foundation
import Alamofire



class ApiManager {
    
    static func request<T:Codable>(url:URL, completion:@escaping(_ response:T?,_ error:Error?)->Void) {
        let session = URLSession.shared
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            // Do something...
            
            if let data = data ,error == nil {
                let decoded = try! JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(decoded,nil)
                }
                
            }
            else {
                DispatchQueue.main.async {
                    completion(nil,error)
                }
            }
        })
        task.resume()
  
        
        
    }
    
    
}


