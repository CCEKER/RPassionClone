//
//  TourDetailsFlowCoordinatorAssembly.swift
//  TourApp
//
//  Created by Cagatay Ceker on 8.02.2024.
//

import Foundation
import Swinject

final class TourDetailsFlowCoordinatorAssembly: Assembly {
    func assemble(container: Container) {
        container.register(TourDetailServiceProtocol.self) { resolver in
            let userService = resolver.resolve(UserServiceProtocol.self)!
            return TourDetailService(userService: userService)
        }
    }
}
