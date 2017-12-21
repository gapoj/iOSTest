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
    let desc: String
    let language: String?
    let stargazers: Int
    let forks: Int
    let owner: Owner
    let htmlUrl: String
}
    /// Mark: - extension Repository
    /// Put init functions inside extension so default constructor
    /// for the struct is created
extension Repository {
    init?(json: JSON) {
        
         id = json["id"].intValue
         fullName = json["full_name"].stringValue
         desc = json["description"].stringValue
         language = json["language"].string
        stargazers = json["stargazers_count"].intValue
        forks = json["forks"].intValue
       
        
        owner = Owner(json:json["owner"])
       
        htmlUrl = json["html_url"].stringValue
        
    }
}
