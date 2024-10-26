//
//  MockUserRepository.swift
//  GithubUserTrackerTests
//
//  Created by 박성근 on 10/26/24.
//

import Foundation
@testable import GithubUserTracker

public struct MockUserRepository: UserRepositoryProtocol {
    public func fetchUser(query: String, page: Int) async -> Result<GithubUserTracker.UserListResult, GithubUserTracker.NetworkError> {
        .failure(.dataNil)
    }
    
    public func getFavoriteUsers() -> Result<[GithubUserTracker.UserListItem], GithubUserTracker.CoreDataError> {
        .failure(.entityNotFound(""))
    }
    
    public func saveFavoriteUser(user: GithubUserTracker.UserListItem) -> Result<Bool, GithubUserTracker.CoreDataError> {
        .failure(.entityNotFound(""))
    }
    
    public func deleteFavoriteUser(userID: Int) -> Result<Bool, GithubUserTracker.CoreDataError> {
        .failure(.entityNotFound(""))
    }
}
