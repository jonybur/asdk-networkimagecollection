//
//  InstagramClient.swift
//  Sample
//
//  Created by Jonathan Bursztyn on 1/10/17.
//  Copyright © 2017 Jonathan Bursztyn. All rights reserved.
//

import Foundation
import SwiftyJSON
import PromiseKit

class InstagramClient{
    
    public static func getInstagramPage(username : String) -> Promise<[Picture]>{
        
        return Promise{ fulfill, reject in
        
            let url = URL(string: "https://www.instagram.com/"+username+"/media/");
            var request = URLRequest(url: url! as URL)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request){ data,response,error in
                if error == nil && data != nil {
                    let json = JSON(data: data!)["items"]
                    
                    var section : [Picture] = [Picture]();
                    
                    for i in 0...json.count{
                        let imageUrl = json[i]["images"]["standard_resolution"]["url"].stringValue
                        let username = json[i]["user"]["full_name"].stringValue
                        let picture = Picture(withUrl: imageUrl, andUsername: username)
                        section.append(picture);
                    }
                    
                    fulfill(section);
                    
                } else {
                
                    reject(error!);
                    
                }
            }.resume()
        
        }
    }

    
}
