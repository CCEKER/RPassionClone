//
//  WelcomeFlowCoordinatorModule.swift
//  TourApp
//
//  Created by Cagatay Ceker on 26.02.2024.
//

import Foundation
import Swinject

protocol WelcomeFlowCoordinatorResolver {
    func resolveWelcomeViewController(delegate: WelcomeInteractorCoordinatorDelegate) -> UIViewController
}

final class WelcomeFlowCoordinatorModule: WelcomeFlowCoordinatorResolver {
    
    private let container: Container
    private let resolver: Resolver
    
    init(parentContainer: Container) {
        container = Container(parent: parentContainer)
        _ = Assembler([WelcomeFlowCoordinatorAssembly()], container: container)
        self.resolver = container
    }
    
    func resolveWelcomeViewController(delegate: WelcomeInteractorCoordinatorDelegate) -> UIViewController {
        WelcomeViewController.build(coordinator: delegate)
    }
}
