//
//  ReposTableViewViewModel.swift
//  test_iOS
//
//  Created by Guillermo Apoj on 20/12/17.
//  Copyright © 2017 Guillermo Apoj. All rights reserved.
//

import Foundation

class ReposTableViewViewModel {
    enum RepoCellType {
        case normal(cellViewModel: RepoCellViewModel)
        case error(message: String)
        case empty
    }
    let repoCells = Bindable([RepoCellType]())
    let appServerClient: AppServerClient
    
    init(appServerClient: AppServerClient = AppServerClient()) {
        self.appServerClient = appServerClient
    }
    func getRepos() {
        //showLoadingHud.value = true
        appServerClient.getRepos(success: { [weak self](repos) in
            guard repos.count > 0 else {
                                   self?.repoCells.value = [.empty]
                                    return
                                }
            self?.repoCells.value = repos.flatMap { .normal(cellViewModel: $0 as RepoCellViewModel)}
        }) { (error) in
            self.repoCells.value = [.error(message: "Loading failed, check network connection")]
            }
        
    }
    
}

