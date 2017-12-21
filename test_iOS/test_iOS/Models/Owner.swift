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
    let imageURL: String
    let url: String
}
    /// Mark: - extension Owner
    /// Put init functions inside extension so default constructor
    /// for the struct is created
    extension Owner {
    init(json: JSON) {
        imageURL = json["avatar_url"].stringValue
        name = json["login"].stringValue
        url = json["url"].stringValue
     }
}
