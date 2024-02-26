//
//  DashboardFlowCoordinator.swift
//  TourApp
//
//  Created by Cagatay Ceker on 25.01.2024.
//

import UIKit

protocol DashboardFlowCoordinatorProtocol {
    func start()
}

protocol DashboardFlowCoordinatorDelegate: AnyObject {
    func profileFlowCoordinatorDidFinish()
    func garageFlowCoordinatorDidFinish()
}

final class DashboardFlowCoordinator: DashboardFlowCoordinatorProtocol {
    
    weak var delegate: DashboardFlowCoordinatorDelegate?
    private let window: UIWindow
    private var homePageFlowCoordiantor: HomePageFlowCoordinatorProtocol?
    private var profileFlowCoordinator: ProfileFlowCoordinatorProtocol?
    private var garageFlowCoordinator: GarageFlowCoordinatorProtocol?
    private let resolver: DashboardFlowCoordinatorResolver
    
    init(window: UIWindow, delegate: DashboardFlowCoordinatorDelegate, resolver: DashboardFlowCoordinatorResolver) {
        self.window = window
        self.delegate = delegate
        self.resolver = resolver
    }
    
    func start() {
        let tabBarController = UITabBarController()
        let navigationController = UINavigationController(rootViewController: tabBarController)
		navigationController.setNavigationBarHidden(true, animated: false)
        self.window.rootViewController = navigationController
        
        homePageFlowCoordiantor = resolver.resolveHomePageFlowCoordinator(tabBarController: tabBarController, delegate: self)
        homePageFlowCoordiantor?.start()
        
        garageFlowCoordinator = resolver.resolveGarageFlowCoordinator(tabBarController: tabBarController, delegate: self)
        garageFlowCoordinator?.start()
        
        profileFlowCoordinator = resolver.resolveProfileFlowCoordinator(tabBarController: tabBarController, delegate: self)
        profileFlowCoordinator?.start()
    }
}

extension DashboardFlowCoordinator: HomePageFlowCoordinatorDelegate {
  
}

extension DashboardFlowCoordinator: ProfileFlowCoordinatorDelegate {
    
    func profileFlowCoordinatorDidFinish() {
        delegate?.profileFlowCoordinatorDidFinish()
    }
}

extension DashboardFlowCoordinator: GarageFlowCoordinatorDelegate {
    
    func GarageFlowCoordinatorDidFinish() {
        delegate?.garageFlowCoordinatorDidFinish()
    }
}
