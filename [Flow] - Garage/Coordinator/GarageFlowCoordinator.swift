//
//  GarageFlowCoordinator.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import Foundation
import UIKit

protocol GarageFlowCoordinatorProtocol {
    func start()
}

protocol GarageFlowCoordinatorDelegate {
    func GarageFlowCoordinatorDidFinish()
}

final class GarageFlowCoordinator: GarageFlowCoordinatorProtocol {
    
    private let tabBarController: UITabBarController
    private let delegate: GarageFlowCoordinatorDelegate
    private var navigationController = UINavigationController()
    private var resolver: GarageFlowCoordinatorResolver
    private var addCarModelFlowCoordinator: AddCarFlowCoordinatorProtocol?
    private var garageViewController: GarageViewController?
    
    init(tabBarController: UITabBarController, delegate: GarageFlowCoordinatorDelegate, resolver: GarageFlowCoordinatorResolver) {
        self.tabBarController = tabBarController
        self.delegate = delegate
        self.resolver = resolver
    }
    
    func start() {
        let garageViewController = resolver.resolveMyGarageViewController(coordinator: self)
        self.garageViewController = garageViewController
        let navigationController = UINavigationController(rootViewController: garageViewController)
        self.navigationController = navigationController
        
        if tabBarController.viewControllers == nil {
            tabBarController.viewControllers = [navigationController]
        } else {
            tabBarController.viewControllers?.append(navigationController)
        }
    }
}

extension GarageFlowCoordinator: GarageInteractorCoordinatorDelegate {
    
    func didTapAddCarButton() {
        addCarModelFlowCoordinator = resolver.resolveAddCarFlow(delegate: self, presentingViewController: self.navigationController)
        addCarModelFlowCoordinator?.start()
    }
    
    func myGarageFlowDidFinish() {
        delegate.GarageFlowCoordinatorDidFinish()
    }
}

extension GarageFlowCoordinator: AddCarFlowCoordinatorDelegate {
    
    func addCarFlowCoordinatorDidFinish(createdCar: Car) {
        
        guard let garageViewController else { return }
        garageViewController.addCarToList(newCar: createdCar)
        navigationController.popToViewController(garageViewController, animated: true)
    }
}
