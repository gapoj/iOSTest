//
//  AppServerClient.swift
//  test_iOS
//
//  Created by Guillermo Apoj on 19/12/17.
//  Copyright © 2017 Guillermo Apoj. All rights reserved.
//

import Alamofire
import SwiftyJSON
import ReactiveCocoa
import ReactiveSwift

// MARK: - AppServerClient
class AppServerClient {
    let baseURL = "https://api.github.com/"
    
    func getAvatar(url: String) -> SignalProducer<UIImage,NSError>
    {
        return SignalProducer { observer, disposable in

                    Alamofire.request(url).responseData(completionHandler: { (data) in
                        guard data.error == nil else {
                            observer.send(value: #imageLiteral(resourceName: "user-filled"))
                            observer.sendCompleted()
                            return
                        }
                        if let str = UIImage(data: data.data!){
                            observer.send(value:str)
                          
                        }else{
                           
                            observer.send(value:#imageLiteral(resourceName: "user-filled"))
                        }
                         observer.sendCompleted()
                    })
            }

  
}
func getReadMe(owner: String, repoName: String) -> SignalProducer<String,NSError> {
    let url = baseURL + "repos/\(owner)/\(repoName)/readme"
     return SignalProducer { observer, disposable in
        Alamofire.request(url)
        .validate()
        .responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    let download = json["download_url"].stringValue
                    Alamofire.request(download).responseData(completionHandler: { (data) in
                        guard data.error == nil else {
                            observer.send(error: data.error! as NSError)
                            observer.sendCompleted()
                            return
                        }
                        if let str = String(data: data.data!, encoding: String.Encoding.utf8){
                           observer.send(value: str)
                            observer.sendCompleted()
                        }else{
                            observer.send(value:"# No Readme to show")
                            observer.sendCompleted()
                        }
                    })
                }
            case .failure(_):
                observer.send(error: response.error! as NSError)
                observer.sendCompleted()
            }
            
    }
    }
}
    func getRepos(withQuery q: String) -> SignalProducer<Array<Repository>,NSError> {
       //canceling previus requests, is only important here since we bring more data and we can do multiple requests
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach { $0.cancel() }
            uploadTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }
        }
        let parameters = ["q": q,
                      "sort" : "stars",
                      "order" : "desc",
                      "page" : 0,
                      "per_page" :100
        ] as [String : Any]
    let url = baseURL + "search/repositories"
    return SignalProducer { observer, disposable in
        Alamofire.request(url , parameters: parameters)
        .validate()
        .responseJSON { response in
            switch response.result {
            case .success:
                 var repos:Array = Array<Repository>()
                if let value = response.result.value {
                    if  let data:[JSON] = JSON(value)["items"].array {
                        repos = data.flatMap {
                             Repository(json: $0)
                        }
                    }
                   
                }
                 observer.send(value: repos)
                 observer.sendCompleted()
            case .failure(_):
                observer.send(error:response.error! as NSError)
                observer.sendCompleted()
            }
    }
    }
}



}

