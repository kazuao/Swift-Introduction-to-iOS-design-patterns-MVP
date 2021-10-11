//
//  SearchUserViewController.swift
//  introduction_to_ios_design_pattern-sample
//
//  Created by kazunori.aoki on 2021/10/08.
//

import UIKit
import GitHub

class SearchUserViewController: UIViewController {

    // MARK: UI
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: Variable
    private var presenter: SearchUserPresenterInput!
    
    
    // MARK: Initialize
    func inject(presenter: SearchUserPresenterInput) {
        self.presenter = presenter
    }
    
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}


// MARK: - Setup
private extension SearchUserViewController {
    
    func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
    }
}


extension SearchUserViewController: UISearchBarDelegate {
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.didTapSearchButton(text: searchBar.text)
    }
}

extension SearchUserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectRow(at: indexPath)
    }
}

extension SearchUserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfUsers
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as! UserTableViewCell
        
        if let user = presenter.user(forRow: indexPath.row) {
            cell.configure(user: user)
        }
        
        return cell
    }
}

extension SearchUserViewController: SearchUserPresenterOutput {
    func updateUsers(_ user: [User]) {
        tableView.reloadData()
    }
    
    func transitionToUserDetail(userName: String) {
        let userDetailVC = UIStoryboard(name: "UserDetail", bundle: nil)
            .instantiateInitialViewController() as! UserDetailViewController
        
        let model = UserDetailModel(userName: userName)
        let presenter = UserDetailPresenter(
            userName: userName,
            view: userDetailVC,
            model: model)
        userDetailVC.inject(presenter: presenter)

        navigationController?.pushViewController(userDetailVC, animated: true)
    }
    
    
}
