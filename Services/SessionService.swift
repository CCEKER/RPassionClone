//
//  SessionService.swift
//  TourApp
//
//  Created by Cagatay Ceker on 31.01.2024.
//

import Foundation

protocol SessionServiceProtocol {
    var token: String? { get }
    func logout()
}

final class SessionService: SessionServiceProtocol {
    var token: String?
    
    func logout() {
        token = nil
    }
}
