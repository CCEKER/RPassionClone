//
//  ApplicationFlowCoordinator+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 31.01.2024.
//

import Foundation
import Swinject

extension ApplicationFlowCoordinator {
    static func build(window: UIWindow, container: Container) -> ApplicationFlowCoordinatorProtocol {
        let module = ApplicationFlowCoordinatorModule(parentContainer: container)
        let userService = container.resolve(UserServiceProtocol.self)!
        return ApplicationFlowCoordinator(window: window, resolver: module, userService: userService)
    }
}
