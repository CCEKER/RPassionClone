//
//  GarageFlowCoordinatorAssembly.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import Foundation
import Swinject

final class GarageFlowCoordinatorAssembly: Assembly {
    func assemble(container: Container) {
        container.register(CarServiceProtocol.self) { resolver in
            let userService = resolver.resolve(UserServiceProtocol.self)!
            return CarService(userService: userService)
        }
    }
}
