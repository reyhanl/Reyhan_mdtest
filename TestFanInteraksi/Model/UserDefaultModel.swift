//
//  UserDefaultModel.swift
//  TestFanInteraksi
//
//  Created by reyhan muhammad on 28/05/24.
//

import Foundation

//This is use for user data that is fetched from the server not firebase
struct UserDefaultModel: Codable{
    var uid: String
    var email: String
    var emailVerified: Bool
}
