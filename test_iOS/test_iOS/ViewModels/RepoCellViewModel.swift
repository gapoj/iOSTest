//
//  RepoCellViewModel.swift
//  test_iOS
//
//  Created by Guillermo Apoj on 20/12/17.
//  Copyright © 2017 Guillermo Apoj. All rights reserved.
//

import UIKit

protocol  RepoCellViewModel {
    var repoItem: Repository { get }
    var name: String { get }
    var stars: String { get }
    var description: String { get }
}

extension Repository: RepoCellViewModel {
    var repoItem: Repository {
        return self
    }
    var name: String {
     return fullName
    }
    var stars: String {
        return "★\(stargazers)"
    }
    var description: String {
      return desc
    }
}
