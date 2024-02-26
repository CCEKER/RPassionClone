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
    func resolveWelcomeFlowCoordinator(window: UIWindow, delegate: WelcomeFlowCoordinatorDelegate) -> WelcomeFlowCoordinatorProtocol
    func resolveLoginFlowCoordinator(window: UIWindow, delegate: LoginFlowCoordinatorDelegate) -> LoginFlowCoordinatorProtocol
    func resolveDashBoardFlowCoordinator(window: UIWindow, delegate: DashboardFlowCoordinatorDelegate) -> DashboardFlowCoordinatorProtocol
    func resolveRegisterFlowCoordinator(window: UIWindow, delegate: RegisterFlowCoordinatorDelegate) -> RegisterFlowCoordinatorProtocol
}

final class ApplicationFlowCoordinatorModule: ApplicationFlowCoordinatorResolver {
    
    private let container: Container
    
    init(parentContainer: Container) {
        container = Container(parent: parentContainer)
        _ = Assembler([ApplicationFlowCoordinatorAssembly()], container: container)
    }
    
    func resolveWelcomeFlowCoordinator(window: UIWindow, delegate: WelcomeFlowCoordinatorDelegate) -> WelcomeFlowCoordinatorProtocol {
        WelcomeFlowCoordinator.build(window: window, delegate: delegate, container: container)
    }
    
    func resolveLoginFlowCoordinator(window: UIWindow, delegate: LoginFlowCoordinatorDelegate) -> LoginFlowCoordinatorProtocol {
        LoginFlowCoordinator.build(window: window, delegate: delegate, container: container)
    }
    
    func resolveDashBoardFlowCoordinator(window: UIWindow, delegate: DashboardFlowCoordinatorDelegate) -> DashboardFlowCoordinatorProtocol {
        DashboardFlowCoordinator.build(window: window, delegate: delegate, container: container)
    }
    
    func resolveRegisterFlowCoordinator(window: UIWindow, delegate: RegisterFlowCoordinatorDelegate) -> RegisterFlowCoordinatorProtocol {
        RegisterFlowCoordinator.build(window: window, delegate: delegate, container: container)
    }
}
