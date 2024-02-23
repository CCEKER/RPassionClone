//
//  MyGarageFlowCoordinator.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import Foundation
import UIKit

protocol MyGarageFlowCoordinatorProtocol {
    func start()
}

protocol MyGarageFlowCoordinatorDelegate {
    func myGarageFlowCoordinatorDidFinish()
}

final class MyGarageFlowCoordinator: MyGarageFlowCoordinatorProtocol {
    
    private let tabBarController: UITabBarController
    private let delegate: MyGarageFlowCoordinatorDelegate
    private var navigationController = UINavigationController()
    private var resolver: MyGarageFlowCoordinatorResolver
    private var addCarModelFlowCoordinator: AddCarFlowCoordinatorProtocol?
    private var myGarageViewController: MyGarageViewController?
    
    init(tabBarController: UITabBarController, delegate: MyGarageFlowCoordinatorDelegate, resolver: MyGarageFlowCoordinatorResolver) {
        self.tabBarController = tabBarController
        self.delegate = delegate
        self.resolver = resolver
    }
    
    func start() {
        let myGarageViewController = resolver.resolveMyGarageViewController(coordinator: self)
        self.myGarageViewController = myGarageViewController
        let navigationController = UINavigationController(rootViewController: myGarageViewController)
        self.navigationController = navigationController
        
        if tabBarController.viewControllers == nil {
            tabBarController.viewControllers = [navigationController]
        } else {
            tabBarController.viewControllers?.append(navigationController)
        }
    }
}

extension MyGarageFlowCoordinator: MyGarageInteractorCoordinatorDelegate {
    
    func didTapAddCarButton() {
        addCarModelFlowCoordinator = resolver.resolveAddCarFlow(delegate: self, presentingViewController: self.navigationController)
        addCarModelFlowCoordinator?.start()
    }
    
    func myGarageFlowDidFinish() {
        delegate.myGarageFlowCoordinatorDidFinish()
    }
}

extension MyGarageFlowCoordinator: AddCarFlowCoordinatorDelegate {
    
    func addCarFlowCoordinatorDidFinish(createdCar: Car) {
        
        guard let myGarageViewController else { return }
        myGarageViewController.addCarToList(newCar: createdCar)
        navigationController.popToViewController(myGarageViewController, animated: true)
    }
}
