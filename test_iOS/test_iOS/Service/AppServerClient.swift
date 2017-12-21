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
    let baseURL = "https://api.github.com/"
    
    func getAvatar(url: String,success:@escaping (UIImage) -> Void, failure:@escaping (Error?) -> Void){
         Alamofire.request(url).responseData(completionHandler: { (data) in
            guard data.error == nil else {
                failure(data.error)
                return
            }
            if let str = UIImage(data: data.data!){
                success(str)
            }else{
                success(#imageLiteral(resourceName: "user-filled"))
            }
        })
  
}
func getReadMe(owner: String, repoName: String,success:@escaping (String) -> Void, failure:@escaping (Error?) -> Void){
    let url = baseURL + "repos/\(owner)/\(repoName)/readme"
    Alamofire.request(url, method: .get)
        .validate()
        .responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    let download = json["download_url"].stringValue
                    Alamofire.request(download).responseData(completionHandler: { (data) in
                        guard data.error == nil else {
                            failure(data.error)
                            return
                        }
                        if let str = String(data: data.data!, encoding: String.Encoding.utf8){
                            success(str)
                        }else{
                            success("# No Readme to show")
                        }
                    })
                }
            case .failure(_):
                failure(response.error)
            }
            
    }
}
func getRepos(success:@escaping ( Array<Repository>) -> Void, failure:@escaping (Error?) -> Void) {
    let parameters = ["q": "created:>2017-12-01",
                      "sort" : "stars",
                      "order" : "desc",
                      "page" : 0,
                      "per_page" :10
        ] as [String : Any]
    Alamofire.request(baseURL + "search/repositories", method: .get, parameters: parameters)
        .validate()
        .responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    // handle the results as JSON, without a bunch of nested if loops
                    var clients:Array = Array<Repository>()
                    if  let data:[JSON] = JSON(value)["items"].array {
                        
                        for json in data
                        {
                            if let model = Repository(json: json){
                                clients.append(model)
                            }
                        }
                    }
                    success(clients)
                }
            case .failure(_):
                failure(response.error)
            }
    }
}



}

