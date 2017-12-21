//
//  RepoDetailsViewController.swift
//  test_iOS
//
//  Created by Guillermo Apoj on 20/12/17.
//  Copyright © 2017 Guillermo Apoj. All rights reserved.
//

import UIKit
import WebKit

class RepoDetailsViewController: UIViewController {

    @IBOutlet weak var readMeWV: WKWebView!
    @IBOutlet weak var projectDescriptionlbl: UILabel!
    @IBOutlet weak var ownerNameLbl: UILabel!
    @IBOutlet weak var ownerImage: UIImageView!
    var viewModel: RepoDetailsViewModel?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
  }

    
    @IBAction func backBtnAction(_ sender: Any) {
        dismiss(animated: true
            , completion: nil)
    }
    
    private func bindViewModel() {
        ownerNameLbl.text = viewModel?.ownerName
        projectDescriptionlbl.text = viewModel?.repoDescription
        if let readMeURL = viewModel?.readMeURL {
            let myRequest = URLRequest(url:readMeURL)
            readMeWV.load(myRequest)
        }
        self.navigationItem.title = viewModel?.projectName
    }
  

}
