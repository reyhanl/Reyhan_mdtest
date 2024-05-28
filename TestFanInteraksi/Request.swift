//
//  Request.swift
//  TestFanInteraksi
//
//  Created by reyhan muhammad on 28/05/24.
//

import Foundation

protocol RequestProtocol{
    var path: URLManager{get}
    var method: HTTPMethod{get}
    var contentType: ContentType{get}
}

enum RequestEnum: RequestProtocol{
    var method: HTTPMethod{
        switch self{
        case .fetchUsers:
            return .get
        }
    }
    
    var contentType: ContentType{
        switch self{
        case .fetchUsers:
            return .json
        }
    }
    
    
    case fetchUsers
    
    var path: URLManager{
        switch self{
        case .fetchUsers:
            return .fetchUsers
        }
    }
}
