//
//  MyGarageFlowCoordinatorModule.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import Foundation
import Swinject
import UIKit

protocol MyGarageFlowCoordinatorResolver {
    func resolveMyGarageViewController(coordinator: MyGarageInteractorCoordinatorDelegate) -> MyGarageViewController
    func resolveAddCarFlow(delegate: AddCarFlowCoordinatorDelegate, presentingViewController: UINavigationController) -> AddCarFlowCoordinatorProtocol
}

final class MyGarageFlowCoordinatorModule: MyGarageFlowCoordinatorResolver {
    
    private let resolver: Resolver
    private let container: Container
  
    init(parentContainer: Container) {
        container = Container(parent: parentContainer)
        _ = Assembler([MyGarageFlowCoordinatorAssembly()], container: container)
        self.resolver = container
    }
    
    func resolveMyGarageViewController(coordinator: MyGarageInteractorCoordinatorDelegate) -> MyGarageViewController {
        let carService = resolver.resolve(CarServiceProtocol.self)!
        let userService = resolver.resolve(UserServiceProtocol.self)!
        guard let userId = userService.user?.id else {
            fatalError("UserId expected...")
        }
        let myGarageViewController = MyGarageViewController.build(coordinator: coordinator, carService: carService, userId: userId)
        return myGarageViewController
    }
    
    func resolveAddCarFlow(delegate: AddCarFlowCoordinatorDelegate, presentingViewController: UINavigationController) -> AddCarFlowCoordinatorProtocol {
        let addCarFlowCoordinator = AddCarFlowCoordinator.build(delegate: delegate, container: container, presentingViewController: presentingViewController)
        return addCarFlowCoordinator
    }
}
