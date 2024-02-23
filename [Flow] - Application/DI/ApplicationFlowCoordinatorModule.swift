//
//  ApplicationFlowCoordinatorModule.swift
//  TourApp
//
//  Created by Cagatay Ceker on 31.01.2024.
//

import Foundation
import Swinject
import UIKit

protocol ApplicationFlowCoordinatorResolver {
    func resolveLoginFlowCoordinator(window: UIWindow, delegate: LoginFlowCoordinatorDelegate) -> LoginFlowCoordinatorProtocol
    func resolveDashBoardFlowCoordinator(window: UIWindow, delegate: DashboardFlowCoordinatorDelegate) -> DashboardFlowCoordinatorProtocol
}

final class ApplicationFlowCoordinatorModule: ApplicationFlowCoordinatorResolver {
    
    private let container: Container
    
    init(parentContainer: Container) {
        container = Container(parent: parentContainer)
        _ = Assembler([ApplicationFlowCoordinatorAssembly()], container: container)
    }
    
    func resolveLoginFlowCoordinator(window: UIWindow, delegate: LoginFlowCoordinatorDelegate) -> LoginFlowCoordinatorProtocol {
        LoginFlowCoordinator.build(window: window, delegate: delegate, container: container)
    }
    
    func resolveDashBoardFlowCoordinator(window: UIWindow, delegate: DashboardFlowCoordinatorDelegate) -> DashboardFlowCoordinatorProtocol {
        DashboardFlowCoordinator.build(window: window, delegate: delegate, container: container)
    }
}
