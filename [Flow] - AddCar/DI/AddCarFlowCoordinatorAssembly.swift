//
//  AddCarFlowCoordinatorAssembly.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import Foundation
import Swinject

final class AddCarFlowCoordinatorAssembly: Assembly {
    func assemble(container: Container) {
        
        container.register(BrandServiceProtocol.self) { resolver in
            let userService = resolver.resolve(UserServiceProtocol.self)!
            return BrandService(userService: userService)
        }
        
        container.register(CarServiceProtocol.self) { resolver in
            let userService = resolver.resolve(UserServiceProtocol.self)!
            return CarService(userService: userService)
        }
    }
}
