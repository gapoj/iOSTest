//
//  AppServerClient.swift
//  test_iOS
//
//  Created by Guillermo Apoj on 19/12/17.
//  Copyright © 2017 Guillermo Apoj. All rights reserved.
//

import Alamofire
import SwiftyJSON

// MARK: - AppServerClient
class AppServerClient {
    


    func getRepos(success:@escaping ( Array<Repository>) -> Void, failure:@escaping (Error?) -> Void) {
        let parameters = ["q": "created:>2017-12-01",
                          "sort" : "stars",
                          "order" : "desc",
                          "page" : 0,
                          "per_page" :10
            ] as [String : Any]
        Alamofire.request("https://api.github.com/search/repositories", method: .get, parameters: parameters)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let value = response.result.value {
                        // handle the results as JSON, without a bunch of nested if loops
                        let data:[JSON] = JSON(value)["items"].array!
                        // print(data)
                        var clients:Array = Array<Repository>()
                        
                        for json in data
                        {
                            let model = Repository(json: json)
                            clients.append(model)
                        }
                        success(clients)
                    }
                case .failure(_):
                   failure(response.error)
                }
        }
    }
    

    
}

