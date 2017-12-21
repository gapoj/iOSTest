//
//  RepoDetailsViewModel.swift
//  test_iOS
//
//  Created by Guillermo Apoj on 20/12/17.
//  Copyright © 2017 Guillermo Apoj. All rights reserved.
//
import UIKit

class   RepoDetailsViewModel {
    var repo: Repository
    var projectName: String {
        return repo.fullName
    }
    var starsNumber: String {
        return "\(repo.stargazers) Stars"
    }
    var repoDescription: String {
        return repo.desc
    }
    var forksNumber: String {
        return "\(repo.forks) Forks"
    }
    var readMeURL: URL? {
        let stringUrl = repo.htmlUrl + "/blob/master/README.md"
        guard let url = URL(string: stringUrl) else{
            return nil
            
        }
        return url
    }
    var ownerName: String {
        return repo.owner.name
    }
    init(withRepo repository: Repository) {
        repo = repository
    }
}


