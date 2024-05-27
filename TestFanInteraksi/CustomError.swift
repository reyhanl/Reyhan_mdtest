//
//  CustomError.swift
//  TestFanInteraksi
//
//  Created by reyhan muhammad on 27/05/24.
//

import Foundation

enum CustomError: Error{
    case callApiFailBecauseURLNotFound
    case apiReturnNoData
    case somethingWentWrong
    case fetchFromCoreDataError
    case failedToLoadJson
    case dataAlreadyExist
    case failedToSignIn(String)
    case failedToSignUp(String)
    case pathShouldBeCollection
    case pathShouldBeDocument
    case failedToSignOut
    case failedToUploadToStorage
    case notEnoughBalance
    case refundProblem
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .dataAlreadyExist:
            return NSLocalizedString("Data already exist", comment: "Display this eror when user already have saved that category previously")
        case .failedToSignUp(localizedDescription):
            return localizedDescription
        case .notEnoughBalance:
            return NSLocalizedString("You do not have enough balance", comment: "User does not have enough balance")
        case .failedToUploadToStorage:
            return NSLocalizedString("Failed to upload", comment: "Failed to upload to the server")
        case .refundProblem:
            return NSLocalizedString("Something went wrong with when we try to refund your balance, please contact us for a  refund", comment: "Failed to upload to the server")
        default:
            return NSLocalizedString("Something went wrong", comment: "Something unexpected occured")

        }
    }
}
