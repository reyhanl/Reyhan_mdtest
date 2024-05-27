//
//  UserProfileModel.swift
//  TestFanInteraksi
//
//  Created by reyhan muhammad on 27/05/24.
//

import Foundation

class UserProfileModel: Codable{
    var name: String?
    var id: String?
    var profilePictureUrl: String?
    var isVerified: Bool?
    var email: String?
    
    init(name: String? = nil, id: String? = nil, profilePictureUrl: String? = nil, isVerified: Bool? = nil, email: String? = nil) {
        self.name = name
        self.id = id
        self.profilePictureUrl = profilePictureUrl
        self.isVerified = isVerified
        self.email = email
    }
    
    enum CodingKeys: String, CodingKey{
        case name
        case id
        case profilePictureUrl
        case isVerified
        case email
    }
}
