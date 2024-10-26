//
//  UserListViewModel.swift
//  GithubUserTracker
//
//  Created by 박성근 on 10/26/24.
//

import Foundation
import RxSwift
import RxCocoa

protocol UserListViewModelProtocol {
    
}

public final class UserListViewModel: UserListViewModelProtocol {
    private let usecase: UserListUsecaseProtocol
    private let disposeBag = DisposeBag()
    private let error = PublishRelay<String>()
    private let fetchUserList = BehaviorSubject<[UserListItem]>(value: [])
    private let allFavoriteUserList = BehaviorSubject<[UserListItem]>(value: []) // 즐겨찾기 포함 여부를 확인할 전체 리스트
    private let favoriteUserList = BehaviorSubject<[UserListItem]>(value: []) // 목록에 보여줄 리스트
    
    public init(usecase: UserListUsecaseProtocol) {
        self.usecase = usecase
    }
    
    public struct Input {
        let tabButtonType: Observable<TabButtonType>
        let query: Observable<String>
        let saveFavorite: Observable<UserListItem>
        let deleteFavorite: Observable<Int>
        let fetchMore: Observable<Void>
    }
    
    public struct Output {
        let cellData: Observable<[UserListCellData]>
        let error: Observable<String>
    }
    
    public func transform(input: Input) -> Output {
        input.query.bind { query in
            // TODO: 검색어 변경시 user Fetch or get favorite Users
        }.disposed(by: disposeBag)
        
        input.saveFavorite.bind { user in
            // TODO: 즐겨찾기 추가
        }.disposed(by: disposeBag)
        
        input.deleteFavorite.bind { userID in
            // TODO: 즐겨찾기 삭제
        }.disposed(by: disposeBag)
        
        input.fetchMore.bind {
            // TODO: 다음 페이지 검색
        }.disposed(by: disposeBag)
        
        let cellData: Observable<[UserListCellData]> = Observable.combineLatest(
            input.tabButtonType,
            fetchUserList,
            favoriteUserList
        ).map { tabButtonType, fetchUserList, favoriteUserList in
            let cellData: [UserListCellData] = []
            // TODO: cellData 생성
            return cellData
        }
        
        return Output(
            cellData: cellData,
            error: error.asObservable()
        )
    }
}

public enum TabButtonType {
    case api
    case favorite
}

public enum UserListCellData {
    case user(user: UserListItem, isFavorite: Bool)
    case header(String)
}
