//
//  CreateTourWelcomeFlowCoordinatorModule.swift
//  TourApp
//
//  Created by Cagatay Ceker on 11.03.2024.
//

import Foundation
import Swinject

protocol CreateTourWelcomeFlowCoordinatorResolver {
    func resolveCreateTourWelcomeFlowCoordinator(delegate: CreateTourWelcomeInteractorCoordinatorDelegate) -> UIViewController
    func resolveCreateTourViewController(delegate: CreateTourInteractorCoordinatorDelegate) -> UIViewController
}

final class CreateTourWelcomeFlowCoordinatorModule: CreateTourWelcomeFlowCoordinatorResolver {
    
    private let container: Container
    private let resolver: Resolver
    
    init(parentContainer: Container) {
        container = Container(parent: parentContainer)
        _ = Assembler([CreateTourWelcomeFlowCoordinatorAssembly()], container: container)
        self.resolver = container
    }
    
    func resolveCreateTourWelcomeFlowCoordinator(delegate: CreateTourWelcomeInteractorCoordinatorDelegate) -> UIViewController {
       CreateTourWelcomeViewController.build(coordinator: delegate)
    }
    
    func resolveCreateTourViewController(delegate: CreateTourInteractorCoordinatorDelegate) -> UIViewController {
        guard let tourService = resolver.resolve(TourServiceProtocol.self) else {
            fatalError("TourServiceProtocol must be registered.")
        }
        return CreateTourViewController.build(coordinator: delegate, tourService: tourService)
    }
}
