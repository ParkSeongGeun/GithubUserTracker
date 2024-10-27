//
//  UserListViewModelTests.swift
//  GithubUserTrackerTests
//
//  Created by 박성근 on 10/27/24.
//

import XCTest
@testable import GithubUserTracker
import RxSwift
import RxCocoa

final class UserListViewModelTests: XCTestCase {

    private var viewModel: UserListViewModel!
    private var mockUsecase: MockUserUsecase!
    
    private var tabButtonType: BehaviorRelay<TabButtonType>!
    private var query: BehaviorRelay<String>!
    private var saveFavorite: PublishRelay<UserListItem>!
    private var deleteFavorite: PublishRelay<Int>!
    private var fetchMore: PublishRelay<Void>!
    private var input: UserListViewModel.Input!
    
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        mockUsecase = MockUserUsecase()
        viewModel = UserListViewModel(usecase: mockUsecase)
        tabButtonType = BehaviorRelay<TabButtonType>(value: .api)
        query = BehaviorRelay<String>(value: "")
        saveFavorite = PublishRelay<UserListItem>()
        deleteFavorite = PublishRelay<Int>()
        fetchMore = PublishRelay<Void>()
        
        disposeBag = DisposeBag()
        
        input = UserListViewModel.Input(
            tabButtonType: tabButtonType.asObservable(),
            query: query.asObservable(),
            saveFavorite: saveFavorite.asObservable(),
            deleteFavorite: deleteFavorite.asObservable(),
            fetchMore: fetchMore.asObservable()
        )
    }

    override func tearDown() {
        viewModel = nil
        mockUsecase = nil
        disposeBag = nil
        super.tearDown()
    }
    
    // TODO: Query -> cell data
    func testFetchUserCelldata() {
        let userList = [
            UserListItem(id: 1, login: "user1", imageURL: ""),
            UserListItem(id: 2, login: "user2", imageURL: ""),
            UserListItem(id: 3, login: "user3", imageURL: ""),
        ]
        mockUsecase.fetchUserResult = .success(UserListResult(totalCount: 3, incompleteResults: false, items: userList))
        
        let output = viewModel.transform(input: input)
        query.accept("user")
        var result: [UserListCellData] = []
        output.cellData.bind { cellData in
            result = cellData
        }.disposed(by: disposeBag)
        
        if case .user(let userItem, _) = result.first {
            XCTAssertEqual(userItem.login, "user1")
        } else {
            XCTFail("Cell Data user cell not found")
        }
    }
    
    // TODO: Favoirte List -> cell data
    func testFavoriteUserCelldata() {
        let userList = [
            UserListItem(id: 1, login: "Ash", imageURL: ""),
            UserListItem(id: 2, login: "Brown", imageURL: ""),
            UserListItem(id: 3, login: "Bob", imageURL: ""),
        ]
        mockUsecase.favoriteUserResult = .success(userList)
        let output = viewModel.transform(input: input)
        tabButtonType.accept(.favorite)
        
        var result: [UserListCellData] = []
        output.cellData.bind { cellData in
            result = cellData
        }.disposed(by: disposeBag)
        
        if case let .header(key) = result.first {
            XCTAssertEqual(key, "A")
        } else {
            XCTFail("Cell data header cell not found")
        }
        
        if case .user(let userItem, let isFavorite) = result[1] {
            XCTAssertEqual(userItem.login, "Ash")
            XCTAssertTrue(isFavorite)
        } else {
            XCTFail("Cell data user cell not found")
        }
    }
}
