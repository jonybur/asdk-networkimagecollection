//
//  Picture.swift
//  Sample
//
//  Created by Jonathan Bursztyn on 1/10/17.
//  Copyright © 2017 Jonathan Bursztyn. All rights reserved.
//

import Foundation
import CoreGraphics

class Picture{

    var ratio : CGSize
    var url : String!
    var username : String!
    
    init (withUrl imgurl : String, andUsername name : String){
        
        url = imgurl
        username = name
        ratio = CGSize(width: 1, height: (1.2...1.6).random())

    }
}
