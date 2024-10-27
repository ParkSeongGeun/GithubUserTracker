//
//  MockUserUsecase.swift
//  GithubUserTrackerTests
//
//  Created by 박성근 on 10/27/24.
//

import Foundation
@testable import GithubUserTracker

public class MockUserUsecase: UserListUsecaseProtocol {
    
    public var fetchUserResult: Result<UserListResult, NetworkError>?
    public var favoriteUserResult: Result<[UserListItem], CoreDataError>?
    
    public func fetchUser(query: String, page: Int) async -> Result<GithubUserTracker.UserListResult, GithubUserTracker.NetworkError> {
        fetchUserResult ?? .failure(.dataNil)
    }
    
    public func getFavoriteUsers() -> Result<[GithubUserTracker.UserListItem], GithubUserTracker.CoreDataError> {
        favoriteUserResult ?? .failure(.entityNotFound(""))
    }
    
    public func saveFavoriteUser(user: GithubUserTracker.UserListItem) -> Result<Bool, GithubUserTracker.CoreDataError> {
        .success(true)
    }
    
    public func deleteFavoriteUser(userID: Int) -> Result<Bool, GithubUserTracker.CoreDataError> {
        .success(true)
    }
    
    public func checkFavoriteState(fetchUsers: [UserListItem], favoriteUsers: [UserListItem]) -> [(user: UserListItem, isFavorite: Bool)] {
        let favoriteSet = Set(favoriteUsers)
        return fetchUsers.map { user in
            if favoriteSet.contains(user) {
                return (user: user, isFavorite: true)
            } else {
                return (user: user, isFavorite: false)
            }
        }
    }
    
    public func convertListToDictionary(favoriteUsers: [UserListItem]) -> [String : [UserListItem]] {
        favoriteUsers.reduce(into: [String: [UserListItem]]()) { dict, user in
            if let firstString = user.login.first { // 초성
                let key = String(firstString).uppercased() // 대문자
                dict[key, default: []].append(user)
            }
        }
    }
}
