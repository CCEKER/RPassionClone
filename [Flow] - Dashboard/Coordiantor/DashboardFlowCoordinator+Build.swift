//
//  DashboardFlowCoordinator+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 31.01.2024.
//

import Foundation
import Swinject

extension DashboardFlowCoordinator {
    static func build(window: UIWindow, delegate: DashboardFlowCoordinatorDelegate, container: Container) -> DashboardFlowCoordinatorProtocol {
        let module = DashboardFlowCoordinatorModule(parentContainer: container)
        return DashboardFlowCoordinator(window: window, delegate: delegate, resolver: module)
    }
}
