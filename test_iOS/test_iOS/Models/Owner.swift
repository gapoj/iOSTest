//
//  Owner.swift
//  test_iOS
//
//  Created by Guillermo Apoj on 19/12/17.
//  Copyright © 2017 Guillermo Apoj. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Owner {
    let name: String
    let imageURL: NSURL
    let url: NSURL
init(json: JSON) {
        let json = JSON(json)
        
        imageURL = NSURL(string:json["avatar_url"].stringValue)!
        name = json["login"].stringValue
        url = NSURL(string:json["url"].stringValue)!
        
        
    }
}
