//
//  CreateTourWelcomeFlowCoordinatorAssembly.swift
//  TourApp
//
//  Created by Cagatay Ceker on 11.03.2024.
//

import Foundation
import Swinject

final class CreateTourWelcomeFlowCoordinatorAssembly: Assembly {
    func assemble(container: Container) {
        container.register(TourServiceProtocol.self) { resolver in
            let userService = resolver.resolve(UserServiceProtocol.self)!
            return TourService(userService: userService)
        }
    }
}
