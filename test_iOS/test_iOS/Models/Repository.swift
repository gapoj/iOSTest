//
//  Repository.swift
//  test_iOS
//
//  Created by Guillermo Apoj on 19/12/17.
//  Copyright © 2017 Guillermo Apoj. All rights reserved.
//
import Foundation
import SwiftyJSON

struct Repository {
    let id: Int
    let fullName: String
    let description: String
    let language: String?
//    let stargazers: Int
//    let forks: Int
    let owner: Owner

    init(json: JSON) {
        
         id = json["id"].intValue
         fullName = json["full_name"].stringValue
         description = json["description"].stringValue
         language = json["language"].string
//        let stargazers = json["stargazers_count"].intValue
//        let forks = json["forks"].intValue
        owner = Owner(json:json["owner"])
        
        
    }
}
