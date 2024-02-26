//
//  GarageFlowCoordinatorModule.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import Foundation
import Swinject
import UIKit

protocol GarageFlowCoordinatorResolver {
    func resolveMyGarageViewController(coordinator: GarageInteractorCoordinatorDelegate) -> GarageViewController
    func resolveAddCarFlow(delegate: AddCarFlowCoordinatorDelegate, presentingViewController: UINavigationController) -> AddCarFlowCoordinatorProtocol
}

final class GarageFlowCoordinatorModule: GarageFlowCoordinatorResolver {
    
    private let resolver: Resolver
    private let container: Container
  
    init(parentContainer: Container) {
        container = Container(parent: parentContainer)
        _ = Assembler([GarageFlowCoordinatorAssembly()], container: container)
        self.resolver = container
    }
    
    func resolveMyGarageViewController(coordinator: GarageInteractorCoordinatorDelegate) -> GarageViewController {
        let carService = resolver.resolve(CarServiceProtocol.self)!
        let userService = resolver.resolve(UserServiceProtocol.self)!
        guard let userId = userService.user?.id else {
            fatalError("UserId expected...")
        }
        let garageViewController = GarageViewController.build(coordinator: coordinator, carService: carService, userId: userId)
        return garageViewController
    }
    
    func resolveAddCarFlow(delegate: AddCarFlowCoordinatorDelegate, presentingViewController: UINavigationController) -> AddCarFlowCoordinatorProtocol {
        let addCarFlowCoordinator = AddCarFlowCoordinator.build(delegate: delegate, container: container, presentingViewController: presentingViewController)
        return addCarFlowCoordinator
    }
}
