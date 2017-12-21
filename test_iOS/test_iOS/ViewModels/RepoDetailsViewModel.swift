//
//  RepoDetailsViewModel.swift
//  test_iOS
//
//  Created by Guillermo Apoj on 20/12/17.
//  Copyright © 2017 Guillermo Apoj. All rights reserved.
//
import UIKit

class   RepoDetailsViewModel {
    private let imageSide = 20.0
    let appServerClient: AppServerClient = AppServerClient()
    var repo: Repository
    var readmeStr = Bindable(String())
    var ownerImage = Bindable(#imageLiteral(resourceName: "user-filled"))
    var projectName: String {
        return repo.fullName
    }
    var starsNumber:  NSMutableAttributedString {
        let attachment = NSTextAttachment()
        attachment.image = #imageLiteral(resourceName: "star")
        attachment.bounds = CGRect(x: 0, y: 0, width: imageSide, height:imageSide)
        let attachmentStr = NSAttributedString(attachment: attachment)
        let myString = NSMutableAttributedString(string: "")
        myString.append(attachmentStr)
        let myString1 = NSMutableAttributedString(string: "\(repo.stargazers) Stars")
        myString.append(myString1)
        return myString
    }
    
    var repoDescription: String {
        return repo.desc
    }
    var forksNumber: NSMutableAttributedString {
        let attachment = NSTextAttachment()
        attachment.image = #imageLiteral(resourceName: "fork")
        attachment.bounds = CGRect(x: 0, y: 0, width: imageSide, height:imageSide )
        let attachmentStr = NSAttributedString(attachment: attachment)
        let myString = NSMutableAttributedString(string: "")
        myString.append(attachmentStr)
        let myString1 = NSMutableAttributedString(string: "\(repo.forks) Forks")
        myString.append(myString1)
        return myString
    }
    var ownerName: String {
        return repo.owner.name
    }
    init(withRepo repository: Repository) {
        repo = repository
    }
    
    func getReadMe(){
        appServerClient.getReadMe(owner: ownerName, repoName: repo.reponame, success: { [weak self](string) in
            self?.readmeStr.value = string
        }) { (error) in
            //In this chase I want the app to fail silently
            print("error")
        }
        
    }
    func getAvatar(){
        appServerClient.getAvatar(url: repo.owner.imageURL, success: { [weak self](img) in
            self?.ownerImage.value = img
        }) { (error) in
            //In this chase I want the app to fail silently
            print("error")
        }
    }
}


