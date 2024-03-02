//
//  EditProfileFlowCoordinatorAssembly.swift
//  TourApp
//
//  Created by Cagatay Ceker on 2.03.2024.
//

import Foundation
import Swinject

final class EditProfileFlowCoordinatorAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(AuthServiceProtocol.self) { resolver in
            let userService = resolver.resolve(UserServiceProtocol.self)!
            return AuthService(userService: userService)
        }
    }
}
