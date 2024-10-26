//
//  UserRepository.swift
//  GithubUserTracker
//
//  Created by 박성근 on 10/26/24.
//

import Foundation

public struct UserRepository: UserRepositoryProtocol {
    
    private let coreData: UserCoreDataProtocl
    private let network: UserNetworkProtocol
    
    init(coreData: UserCoreDataProtocl, network: UserNetworkProtocol) {
        self.coreData = coreData
        self.network = network
    }
    
    public func fetchUser(query: String, page: Int) async -> Result<UserListResult, NetworkError> {
        return await network.fetchUser(query: query, page: page)
    }
    
    public func getFavoriteUsers() -> Result<[UserListItem], CoreDataError> {
        return coreData.getFavoriteUsers()
    }
    
    public func saveFavoriteUser(user: UserListItem) -> Result<Bool, CoreDataError> {
        return coreData.saveFavoriteUser(user: user)
    }
    
    public func deleteFavoriteUser(userID: Int) -> Result<Bool, CoreDataError> {
        return coreData.deleteFavoriteUser(userID: userID)
    }
}
