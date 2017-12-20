//
//  ViewController.swift
//  test_iOS
//
//  Created by Guillermo Apoj on 19/12/17.
//  Copyright © 2017 Guillermo Apoj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
let appServerClient = AppServerClient()
        appServerClient.getRepos(success: { (res) in
            print("succes")
        }) { (error) in
            print(error)
        }
    }

}

