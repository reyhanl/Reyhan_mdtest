//
//  FirebaseType.swift
//  TestFanInteraksi
//
//  Created by reyhan muhammad on 27/05/24.
//

import Foundation

enum FirestoreType{
    case document
    case collection
}

enum FirestoreReferenceType{
    case users
    case user(String)
    case custom(String, FirestoreType)
    
    var reference: String{
        switch self{
        case .custom(let reference, _):
            return reference
        case .users:
            return "users/"
        case .user(let id):
            return "users/\(id)"
        }
    }
    
    var type: FirestoreType{
        switch self {
        case .custom(_, let type):
            return type
        case .users:
            return .collection
        case .user(_):
            return .document
        }
    }
    
}
