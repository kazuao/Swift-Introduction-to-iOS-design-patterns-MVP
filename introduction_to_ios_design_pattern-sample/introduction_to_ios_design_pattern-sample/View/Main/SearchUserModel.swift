//
//  SearchUserModel.swift
//  introduction_to_ios_design_pattern-sample
//
//  Created by kazunori.aoki on 2021/10/08.
//

import Foundation

protocol SearchUserModelInput {
    func fetchUser(query: String, completion: @escaping (Result<[User], Error>) -> ())
}

final class SearchUserModel: SearchUserModelInput {
    func fetchUser(query: String, completion: @escaping (Result<[User], Error>) -> ()) {
        
        let user1 = User(login: "1111", id: 1, nodeID: "1111", avatarURL: URL(string: "https://github.com")!, gravatarID: "1111", url:  URL(string: "https://github.com")!, receivedEventsURL:  URL(string: "https://github.com")!, type: "1111")
        
        let user2 = User(login: "1111", id: 1, nodeID: "1111", avatarURL: URL(string: "https://github.com")!, gravatarID: "1111", url:  URL(string: "https://github.com")!, receivedEventsURL:  URL(string: "https://github.com")!, type: "1111")
        
        let user3 = User(login: "1111", id: 1, nodeID: "1111", avatarURL: URL(string: "https://github.com")!, gravatarID: "1111", url:  URL(string: "https://github.com")!, receivedEventsURL:  URL(string: "https://github.com")!, type: "1111")
        
        let user4 = User(login: "1111", id: 1, nodeID: "1111", avatarURL: URL(string: "https://github.com")!, gravatarID: "1111", url:  URL(string: "https://github.com")!, receivedEventsURL:  URL(string: "https://github.com")!, type: "1111")

        
        let users = [user1, user2, user3, user4]
        
        completion(.success(users))
    }
}
