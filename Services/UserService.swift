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
    func checkForSavedUser()
    func logout()
}

final class UserService: UserServiceProtocol {
    var user: User?
    var token: String?
    
    init() {
        self.checkForSavedUser()
    }
        
    
    func updateLoggedInUser(user: User, token: String) {
        self.user = user
        self.token = token
    }
    
    func checkForSavedUser() {
        if let savedUserData = UserDefaults.standard.object(forKey: "user") as? Data {
            if let savedUser = try? JSONDecoder().decode(User.self, from: savedUserData),
               let savedToken = UserDefaults.standard.string(forKey: "token") {
                updateLoggedInUser(user: savedUser, token: savedToken)
            } else {
                self.user = nil
                self.token = nil
            }
        } else {
            self.user = nil
            self.token = nil
        }
    }
    func logout() {
        UserDefaults.standard.removeObject(forKey: "user")
        UserDefaults.standard.removeObject(forKey: "token")
        self.user = nil
        self.token = nil
    }
}
