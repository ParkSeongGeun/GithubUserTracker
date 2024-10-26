//
//  UserRepositoryProtocol.swift
//  GithubUserTracker
//
//  Created by 박성근 on 10/26/24.
//

import Foundation

public protocol UserRepositoryProtocol {
    // 서버에서 유저 리스트 불러오기
    func fetchUser(query: String, page: Int) async -> Result<UserListResult, NetworkError>
    // 전체 즐겨찾기 리스트 불러오기
    func getFavoriteUsers() -> Result<[UserListItem], CoreDataError>
    // 즐겨찾는 유저 저장
    func saveFavoriteUser(user: UserListItem) -> Result<Bool, CoreDataError>
    // 삭제
    func deleteFavoriteUser(userID: Int) -> Result<Bool, CoreDataError>
}
