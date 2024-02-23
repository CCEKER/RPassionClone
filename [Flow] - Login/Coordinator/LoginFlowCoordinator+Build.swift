//
//  LoginFlowCoordinator+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 31.01.2024.
//

import Foundation
import Swinject

extension LoginFlowCoordinator {
    static func build(window: UIWindow, delegate: LoginFlowCoordinatorDelegate, container: Container) -> LoginFlowCoordinatorProtocol {
        let module = LoginFlowCoordinatorModule(parentContainer: container)
        return LoginFlowCoordinator(window: window, delegate: delegate, resolver: module)
    }
}
