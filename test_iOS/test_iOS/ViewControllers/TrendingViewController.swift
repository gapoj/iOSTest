//
//  ViewController.swift
//  test_iOS
//
//  Created by Guillermo Apoj on 19/12/17.
//  Copyright © 2017 Guillermo Apoj. All rights reserved.
//

import UIKit
import MBProgressHUD
import ReactiveSwift
import ReactiveCocoa

class TrendingViewController: UITableViewController {
    let viewModel: ReposTableViewViewModel = ReposTableViewViewModel()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        //so we don't see separators where there are no cells
        tableView.tableFooterView = UIView()
         MBProgressHUD.showAdded(to: tableView, animated: true)
    }
    func bindViewModel() {
        viewModel.repoCells.signal.observe({ [weak self](signal) in
            self?.tableView?.reloadData()
        })

        viewModel.onShowError = { [weak self] alert in
            self?.presentSingleButtonDialog(alert: alert)
        }
        viewModel.showLoadingHud.signal.observe({ [weak self](show) in
            if let validate = show.value,let tv = self?.tableView {
                if  validate {
                    MBProgressHUD.hide(for: tv, animated: true)//just in chase
                    MBProgressHUD.showAdded(to: tv, animated: true)
                } else {
                    MBProgressHUD.hide(for: tv, animated: true)
                }
            }
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRepoDetails",
            let destinationViewController = (segue.destination as? UINavigationController)?.visibleViewController as? RepoDetailsViewController ,
            let indexPath = tableView.indexPathForSelectedRow {
            
            switch viewModel.repoCells.value[indexPath.row] {
            case .normal(let viewModel):
                let viewModel = RepoDetailsViewModel(withRepo: viewModel.repoItem)
                destinationViewController.viewModel = viewModel
            case .empty, .error:
                // nop
                break
            }
        }
    }
}
// MARK: - UISearchBarDelegate
extension TrendingViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText.value = searchText
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

extension TrendingViewController: SingleButtonDialogPresenter{}
