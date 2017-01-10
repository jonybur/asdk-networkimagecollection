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

extension ClosedRange where Bound : FloatingPoint {
    public func random() -> Bound {
        let range = self.upperBound - self.lowerBound
        let randomValue = (Bound(arc4random_uniform(UINT32_MAX)) / Bound(UINT32_MAX)) * range + self.lowerBound
        return randomValue
    }
}
