//
//  UserDetailViewController.swift
//  introduction_to_ios_design_pattern-sample
//
//  Created by kazunori.aoki on 2021/10/08.
//

import UIKit
import GitHub

final class UserDetailViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!

    private var presenter: UserDetailPresenterInput!
    func inject(presenter: UserDetailPresenterInput) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()

        presenter.viewDidLoad()
    }

    private func setup() {
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "RepositoryCell", bundle: nil), forCellReuseIdentifier: "RepositoryCell")
    }
}

extension UserDetailViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.repositories.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell") as! RepositoryCell
        if let repository = presenter.repository(forRow: indexPath.row) {
            cell.configure(with: repository)
        }
        return cell
    }
}

extension UserDetailViewController: UserDetailPresenterOutput {
    func updateRepositories(_ repositories: [Repository]) {
        tableView.reloadData()
    }
}
