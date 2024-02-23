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
    func myGarageFlowCoordinatorDidFinish()
}

final class DashboardFlowCoordinator: DashboardFlowCoordinatorProtocol {
    
    weak var delegate: DashboardFlowCoordinatorDelegate?
    private let window: UIWindow
    private var homePageFlowCoordiantor: HomePageFlowCoordinatorProtocol?
    private var profileFlowCoordinator: ProfileFlowCoordinatorProtocol?
    private var myGarageFlowCoordinator: MyGarageFlowCoordinatorProtocol?
    private let resolver: DashboardFlowCoordinatorResolver
    
    init(window: UIWindow, delegate: DashboardFlowCoordinatorDelegate, resolver: DashboardFlowCoordinatorResolver) {
        self.window = window
        self.delegate = delegate
        self.resolver = resolver
    }
    
    func start() {
        let tabBarController = UITabBarController()
        let navigationController = UINavigationController(rootViewController: tabBarController)
        self.window.rootViewController = navigationController
        
        homePageFlowCoordiantor = resolver.resolveHomePageFlowCoordinator(tabBarController: tabBarController, delegate: self)
        homePageFlowCoordiantor?.start()
        
        myGarageFlowCoordinator = resolver.resolveMyGarageFlowCoordinator(tabBarController: tabBarController, delegate: self)
        myGarageFlowCoordinator?.start()
        
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

extension DashboardFlowCoordinator: MyGarageFlowCoordinatorDelegate {
    
    func myGarageFlowCoordinatorDidFinish() {
        delegate?.myGarageFlowCoordinatorDidFinish()
    }
}
