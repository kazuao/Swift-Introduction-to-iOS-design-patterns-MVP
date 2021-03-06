//
//  UserDetailPresenter.swift
//  introduction_to_ios_design_pattern-sample
//
//  Created by kazunori.aoki on 2021/10/08.
//

import Foundation
import GitHub

protocol UserDetailPresenterInput {
    var repositories: [Repository] { get }
    func repository(forRow row: Int) -> Repository?
    func viewDidLoad()
}

protocol UserDetailPresenterOutput: AnyObject {
    func updateRepositories(_ repositories: [Repository])
}

final class UserDetailPresenter: UserDetailPresenterInput {
    private var userName: String
    private(set) var repositories: [Repository] = []

    private weak var view: UserDetailPresenterOutput!
    private var model: UserDetailModelInput

    init(userName: String, view: UserDetailPresenterOutput, model: UserDetailModelInput) {
        self.userName = userName
        self.view = view
        self.model = model
    }

    func repository(forRow row: Int) -> Repository? {
        guard row < repositories.count else { return nil }
        return repositories[row]
    }

    func viewDidLoad() {
        model.fetchRepositories() { [weak self] result in
            switch result {
            case .success(let repositories):
                self?.repositories = repositories

                DispatchQueue.main.async {
                    self?.view.updateRepositories(repositories)
                }
            case .failure(let error):
                // TODO: Error Handling
                print(error)
                ()
            }
        }
    }
}
