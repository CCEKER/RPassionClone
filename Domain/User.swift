//
//  User.swift
//  TourApp
//
//  Created by Cagatay Ceker on 31.01.2024.
//

import Foundation

struct AuthResponse: Codable {
    let token: String
    let user: User
}

struct User: Codable {
    let userInfo: String?
    let id: String?
    let email: String?
    let isRegistrationCompleted: Bool
    let username: String?
    let dateOfBirth: String?
    let firstName: String?
    let lastName: String?
    let profileImageUrl: String?
    let instagram: String?
    let countryCode: String?
    
    enum CodingKeys: String, CodingKey {
        case userInfo
        case id
        case email
        case isRegistrationCompleted
        case username
        case dateOfBirth
        case firstName
        case lastName
        case profileImageUrl
        case instagram
        case countryCode
    }
}
