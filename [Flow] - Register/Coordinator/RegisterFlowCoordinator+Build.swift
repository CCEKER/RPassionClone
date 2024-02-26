//
//  RegisterFlowCoordinator+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 27.02.2024.
//

import Foundation
import Swinject

extension RegisterFlowCoordinator {
    static func build(window: UIWindow, delegate: RegisterFlowCoordinatorDelegate, container: Container) -> RegisterFlowCoordinatorProtocol {
        let module = RegisterFlowCoordinatorModule(parentContainer: container)
        return RegisterFlowCoordinator(window: window, delegate: delegate, resolver: module)
    }
}
