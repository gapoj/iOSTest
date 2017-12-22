//
//  ReposTableViewViewModel.swift
//  test_iOS
//
//  Created by Guillermo Apoj on 20/12/17.
//  Copyright © 2017 Guillermo Apoj. All rights reserved.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa

class ReposTableViewViewModel {
    
    let repoCells: MutableProperty<[RepoCellType]> = MutableProperty([])
    let appServerClient: AppServerClient
    var onShowError: ((_ alert: SingleButtonAlert) -> Void)?
    let showLoadingHud = MutableProperty<Bool>(false)
    let searchText: MutableProperty<String> = MutableProperty("")
    
    init(appServerClient: AppServerClient = AppServerClient()) {
        self.appServerClient = appServerClient
         searchText.producer.throttle(0.5, on: QueueScheduler.main).map { string in
            self.wordsSubSet(searchTerm: string)
        }.start()
        
    }
       func wordsSubSet(searchTerm: String)  {
    
            guard searchTerm != "" else {
                 showLoadingHud.value = true
                getRepos(withQuery: "created:>\(Date().lastMonth())")
                return
            }
         showLoadingHud.value = true
         getRepos(withQuery:searchTerm)
        }
    
    func getRepos(withQuery q: String) {
       
        appServerClient.getRepos(withQuery: q).observe(on: QueueScheduler.main).on(starting: nil, started: nil, event: nil, failed: { (error) in
            self.showLoadingHud.value = false
            self.repoCells.value = [.error(message: "Loading failed, check network connection")]
        }, completed: nil, interrupted: nil, terminated: nil, disposed: nil,value: { [weak self](repos) in
            self?.showLoadingHud.value = false
            guard repos.count > 0 else {
                self?.repoCells.value = [.empty]
                return
            }
            self?.repoCells.value = repos.flatMap { .normal(cellViewModel: $0 as RepoCellViewModel)}
        }).start()
        
        
    }
    
}

