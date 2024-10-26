//
//  GithubUserTrackerTests.swift
//  GithubUserTrackerTests
//
//  Created by 박성근 on 10/25/24.
//

import XCTest
@testable import GithubUserTracker

final class GithubUserTrackerTests: XCTestCase {

    var usecase: UserListUsecaseProtocol!
    var repository: UserRepositoryProtocol!
    
    
    override func setUp() {
        super.setUp()
        repository = MockUserRepository()
        usecase = UserListUsecase(repository: repository)
    }
    
    override func tearDown() {
        repository = nil
        usecase = nil
        super.tearDown()
    }

    func testCheckFavoriteState() {
        let favoriteUsers = [
            UserListItem(id: 1, login: "user1", imageURL: ""),
            UserListItem(id: 2, login: "user2", imageURL: "")
        ]
        
        let fetchUsers = [
            UserListItem(id: 1, login: "user1", imageURL: ""),
            UserListItem(id: 3, login: "user3", imageURL: "")
        ]
        
        let result = usecase.checkFavoriteState(fetchUsers: fetchUsers, favoriteUsers: favoriteUsers)
        
        XCTAssertEqual(result[0].isFavorite, true)
        XCTAssertEqual(result[1].isFavorite, false)
    }
    
    func testConvertListToDictionary() {
        let users = [
            UserListItem(id: 1, login: "Alice", imageURL: ""),
            UserListItem(id: 2, login: "Bob", imageURL: ""),
            UserListItem(id: 3, login: "Foden", imageURL: ""),
            UserListItem(id: 4, login: "Ash", imageURL: ""),
        ]
        
        let result = usecase.convertListToDictionary(favoriteUsers: users)
        
        XCTAssertEqual(result.keys.count, 3)
        XCTAssertEqual(result["A"]?.count, 2)
        XCTAssertEqual(result["B"]?.count, 1)
        XCTAssertEqual(result["F"]?.count, 1)
    }
}
