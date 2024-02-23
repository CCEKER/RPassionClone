//
//  UserService.swift
//  TourApp
//
//  Created by Cagatay Ceker on 31.01.2024.
//

import Foundation

protocol UserServiceProtocol {
    var user: User? { get set }
    var token: String? { get set }
    func updateLoggedInUser(user: User, token: String)
}

final class UserService: UserServiceProtocol {
    
    var user: User?
    var token: String?
    
    func updateLoggedInUser(user: User, token: String) {
        self.user = user
        self.token = token
    }
}
