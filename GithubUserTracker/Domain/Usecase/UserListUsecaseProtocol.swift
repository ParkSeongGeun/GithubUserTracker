//
//  UserListUsecaseProtocol.swift
//  GithubUserTracker
//
//  Created by 박성근 on 10/26/24.
//

import Foundation

public protocol UserListUsecaseProtocol {
    // 서버에서 유저 리스트 불러오기
    func fetchUser(query: String, page: Int) async -> Result<UserListResult, NetworkError>
    // 전체 즐겨찾기 리스트 불러오기
    func getFavoriteUsers() -> Result<[UserListItem], CoreDataError>
    // 즐겨찾는 유저 저장
    func saveFavoriteUser(user: UserListItem) -> Result<Bool, CoreDataError>
    // 삭제
    func deleteFavoriteUser(userID: Int) -> Result<Bool, CoreDataError>
    
    // 배열 -> Dictionary [초성: [유저리스트]]
    // 유저리스트 - 즐겨찾기 포함된 유저인지 체크
}

public struct UserListUsecase: UserListUsecaseProtocol {
    
    private let repository: UserRepositoryProtocol
    
    public init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }
    
    public func fetchUser(query: String, page: Int) async -> Result<UserListResult, NetworkError> {
        await repository.fetchUser(query: query, page: page)
    }
    
    public func getFavoriteUsers() -> Result<[UserListItem], CoreDataError> {
        repository.getFavoriteUsers()
    }
    
    public func saveFavoriteUser(user: UserListItem) -> Result<Bool, CoreDataError> {
        repository.saveFavoriteUser(user: user)
    }
    
    public func deleteFavoriteUser(userID: Int) -> Result<Bool, CoreDataError> {
        repository.deleteFavoriteUser(userID: userID)
    }
    
    
}
