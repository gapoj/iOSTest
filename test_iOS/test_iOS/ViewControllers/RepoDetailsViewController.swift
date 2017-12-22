//
//  RepoDetailsViewController.swift
//  test_iOS
//
//  Created by Guillermo Apoj on 20/12/17.
//  Copyright © 2017 Guillermo Apoj. All rights reserved.
//

import UIKit
import MarkdownView
import ReactiveCocoa
import ReactiveSwift
import MBProgressHUD
import SafariServices

class RepoDetailsViewController: UIViewController {
    
    @IBOutlet weak var mdview: MarkdownView!
    @IBOutlet weak var projectDescriptionlbl: UILabel!
    @IBOutlet weak var ownerNameLbl: UILabel!
    @IBOutlet weak var ownerImage: UIImageView!
    @IBOutlet weak var starsLbl: UILabel!
    @IBOutlet weak var forksLbl: UILabel!
    
    var viewModel: RepoDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        starsLbl.attributedText = viewModel?.starsNumber
        starsLbl.setGrayBorder()
        forksLbl.attributedText = viewModel?.forksNumber
        forksLbl.setGrayBorder()
        ownerNameLbl.text = viewModel?.ownerName
        projectDescriptionlbl.text = viewModel?.repoDescription
         MBProgressHUD.showAdded(to: self.mdview, animated: true)
        viewModel?.getReadMe().observe(on:QueueScheduler.main).on(starting: {}, started: { }, event:                               { signal in
            print(signal)
        }, failed: {error in
            print(signal)
        }, completed: { }, interrupted: { }, terminated: { }, disposed: { }, value: {[weak self](str) in
            DispatchQueue.main.async {
                self?.mdview.load(markdown:str)
            }
        }).start()
       
        viewModel?.getAvatar().observe(on:QueueScheduler.main).on(starting: {}, started: { }, event:                               { signal in
            print(signal)
        }, failed: {error in
            print(signal)
        }, completed: { }, interrupted: { }, terminated: { }, disposed: { }, value: { (img) in
            self.ownerImage.image = img
        }).start()
        
        self.navigationItem.title = viewModel?.projectName
    }
    
    func configureMarkDown(){
        // called when rendering finished
        mdview.onRendered = { [weak self] height in
            if let view = self?.mdview {
                MBProgressHUD.hide(for: view, animated: true)
            }
            
            self?.mdview.setNeedsLayout()
        }
        
        // called when user touch link
        mdview.onTouchLink = { [weak self] request in
            guard let url = request.url else { return false }
            
            if url.scheme == "file" {
                return false
            } else if url.scheme == "https" {
                let safari = SFSafariViewController(url: url)
                self?.navigationController?.pushViewController(safari, animated: true)
                return false
            } else {
                return false
            }
        }
    }
    
}
