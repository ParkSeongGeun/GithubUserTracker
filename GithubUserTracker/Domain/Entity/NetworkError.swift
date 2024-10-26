//
//  NetworkError.swift
//  GithubUserTracker
//
//  Created by 박성근 on 10/26/24.
//

import Foundation

public enum NetworkError: Error {
    case urlError
    case invalid
    case failTodDecode(String)
    case dataNil
    case serverError(Int)
    case requestFailed(String)
    
    public var description: String {
        switch self {
        case .urlError:
            "URL이 올바르지 않습니다"
        case .invalid: 
            "응답값이 유효하지 않습니다"
        case .failTodDecode(let description):
            "디코딩 에러 \(description)"
        case .dataNil:
            "데이터가 없습니다"
        case .serverError(let statusCode):
            "서버 에러 \(statusCode)"
        case .requestFailed(let message):
            "서버 요청 실패 \(message)"
        }
    }
    
}