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
    
	private var startMode: GarageFlowCoordinator.StartMode
    private let delegate: GarageFlowCoordinatorDelegate
	private let driverId: String
    private var navigationController = UINavigationController()
    private var resolver: GarageFlowCoordinatorResolver
    private var addCarModelFlowCoordinator: AddCarFlowCoordinatorProtocol?
    private var garageViewController: GarageViewController?
    
	init(startMode: GarageFlowCoordinator.StartMode, delegate: GarageFlowCoordinatorDelegate, driverId: String, resolver: GarageFlowCoordinatorResolver) {
        self.startMode = startMode
        self.delegate = delegate
        self.resolver = resolver
		self.driverId = driverId
    }
    
    func start() {
		let garageViewController = resolver.resolveMyGarageViewController(coordinator: self, driverId: driverId)
        self.garageViewController = garageViewController
        
		switch startMode {
		case .toTabBar(let tabBarController):
			
			let navigationController = UINavigationController(rootViewController: garageViewController)
			self.navigationController = navigationController
			
			if tabBarController.viewControllers == nil {
				tabBarController.viewControllers = [navigationController]
			} else {
				tabBarController.viewControllers?.append(navigationController)
			}
			
		case .push(let navigationController):
			self.navigationController = navigationController
			navigationController.pushViewController(garageViewController, animated: true)
			
		case .present(let presentingViewController):
			let navigationController = UINavigationController(rootViewController: garageViewController)
			self.navigationController = navigationController
			presentingViewController.present(navigationController, animated: true)
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
