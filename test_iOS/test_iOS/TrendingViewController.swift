//
//  ViewController.swift
//  test_iOS
//
//  Created by Guillermo Apoj on 19/12/17.
//  Copyright © 2017 Guillermo Apoj. All rights reserved.
//

import UIKit

class TrendingViewController: UITableViewController {
    let viewModel: ReposTableViewViewModel = ReposTableViewViewModel()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.getRepos()
    }
    
    func bindViewModel() {
        viewModel.repoCells.bindAndFire() { [weak self] _ in
            self?.tableView?.reloadData()
        }
        
//        viewModel.onShowError = { [weak self] alert in
//            self?.presentSingleButtonDialog(alert: alert)
//        }
        
//        viewModel.showLoadingHud.bind() { visible in
//            PKHUD.sharedHUD.contentView = PKHUDSystemActivityIndicatorView()
//            visible ? PKHUD.sharedHUD.show() : PKHUD.sharedHUD.hide()
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
}

// MARK: - UITableViewDelegate
extension TrendingViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repoCells.value.count
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch viewModel.repoCells.value[indexPath.row] {
        case .normal(let viewModel):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell") as? RepoCell else {
                return UITableViewCell()
            }
            
            cell.viewModel = viewModel
            return cell
        case .error(let message):
            let cell = UITableViewCell()
            cell.isUserInteractionEnabled = false
            cell.textLabel?.text = message
            return cell
        case .empty:
            let cell = UITableViewCell()
            cell.isUserInteractionEnabled = false
            cell.textLabel?.text = "No data available"
            return cell
        }
    }

}

