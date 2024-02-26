//
//  WelcomeFlowCoordinator+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 26.02.2024.
//

import Foundation
import Swinject

extension WelcomeFlowCoordinator {
    static func build(window: UIWindow, delegate: WelcomeFlowCoordinatorDelegate, container: Container) -> WelcomeFlowCoordinatorProtocol {
        let module = WelcomeFlowCoordinatorModule(parentContainer: container)
        return WelcomeFlowCoordinator(window: window, delegate: delegate, resolver: module)
    }
}
