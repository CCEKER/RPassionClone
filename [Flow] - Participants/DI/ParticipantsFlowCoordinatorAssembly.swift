//
//  ParticipantsFlowCoordinatorAssembly.swift
//  TourApp
//
//  Created by Cagatay Ceker on 20.02.2024.
//

import Foundation
import Swinject

final class ParticipantsFlowCoordinatorAssembly: Assembly {
    func assemble(container: Container) {
        container.register(TourServiceProtocol.self) { resolver in
            let userService = resolver.resolve(UserServiceProtocol.self)!
            return TourService(userService: userService)
        }
    }
}
