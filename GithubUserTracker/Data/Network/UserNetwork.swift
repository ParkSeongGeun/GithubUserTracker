//
//  UserNetwork.swift
//  GithubUserTracker
//
//  Created by 박성근 on 10/26/24.
//

import Foundation

final public class UserNetwork {
    private let manager: NetworkManagerProtocol
    
    init(manager: NetworkManagerProtocol) {
        self.manager = manager
    }
    
    func fetchUsers(query: String, page: Int) async -> Result<UserListResult, NetworkError> {
        let url = "https://api.github.com/search/users?q=\(query)&page=\(page)"
        return await manager.fetchData(url: url, method: .get, parameters: nil)
    }
}
