//
//  RepoDetailsViewController.swift
//  test_iOS
//
//  Created by Guillermo Apoj on 20/12/17.
//  Copyright © 2017 Guillermo Apoj. All rights reserved.
//

import UIKit
import WebKit
import MarkdownView

class RepoDetailsViewController: UIViewController {

    @IBOutlet weak var mdview: MarkdownView!
    @IBOutlet weak var projectDescriptionlbl: UILabel!
    @IBOutlet weak var ownerNameLbl: UILabel!
    @IBOutlet weak var ownerImage: UIImageView!
    var viewModel: RepoDetailsViewModel?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getReadMe()
        viewModel?.getAvatar()
        bindViewModel()
  }
    override func viewDidLayoutSubviews() {
        //crop the image to a circle
        ownerImage.layer.cornerRadius = ownerImage.frame.size.width/2
        ownerImage.clipsToBounds = true
        
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        dismiss(animated: true
            , completion: nil)
    }
    
    private func bindViewModel() {
        ownerNameLbl.text = viewModel?.ownerName
        projectDescriptionlbl.text = viewModel?.repoDescription
        viewModel?.readmeStr.bindAndFire(){ [weak self](str) in
            DispatchQueue.main.async {
                self?.mdview.load(markdown:str)
            }
        }
        viewModel?.ownerImage.bindAndFire() { [weak self](img) in
            DispatchQueue.main.async {
                self?.ownerImage.image = img
                self?.ownerImage.setNeedsLayout()
                self?.ownerImage.layoutIfNeeded()
            }
        }
        self.navigationItem.title = viewModel?.projectName
    }
  

}
