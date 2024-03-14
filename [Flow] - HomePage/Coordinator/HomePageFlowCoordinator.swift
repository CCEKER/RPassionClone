//
//  HomePageFlowCoordinator.swift
//  TourApp
//
//  Created by Cagatay Ceker on 5.01.2024.
//

import UIKit

protocol HomePageFlowCoordinatorProtocol {
    func start()
}

protocol HomePageFlowCoordinatorDelegate {
    
}

final class HomePageFlowCoordinator: HomePageFlowCoordinatorProtocol {
    
    private let tabBarController: UITabBarController
    private let delegate: HomePageFlowCoordinatorDelegate
    private var navigationController = UINavigationController()
    private var resolver: HomePageFlowCoordinatorResolver
    private var tourDetailsFlowCoordinator: TourDetailFlowCoordinatorProtocol?
    private var createTourWelcomeFlowCoordinator: CreateTourWelcomeFlowCoordinatorProtocol?

    init(tabBarController: UITabBarController, delegate: HomePageFlowCoordinatorDelegate, resolver: HomePageFlowCoordinatorResolver) {
        self.tabBarController = tabBarController
        self.delegate = delegate
        self.resolver = resolver
       
    }
    
    func start() {
        let homePageViewController = resolver.resolveHomePageViewController(coordinator: self)
        let navigationController = UINavigationController(rootViewController: homePageViewController)
        tabBarController.tabBar.backgroundColor = .background
        tabBarController.tabBar.unselectedItemTintColor = .white
        tabBarController.tabBar.tintColor = .systemBlue
        self.navigationController = navigationController
        if tabBarController.viewControllers == nil {
            tabBarController.viewControllers = [navigationController]
        } else {
            tabBarController.viewControllers?.append(navigationController)
        }
    }
}

extension HomePageFlowCoordinator: HomePageInteractorCoordinatorDelegate {
    
    func didTapTourDetail(tourId: String) {
        tourDetailsFlowCoordinator = resolver.resolveTourDetailFlow(delegate: self, presenting: self.navigationController, tourId: tourId)
        tourDetailsFlowCoordinator?.start()
    }
    
    func didTapCreateTourButton() {
        createTourWelcomeFlowCoordinator = resolver.resolveCreateTourWelcomeFlowCoordinator(delegate: self, presentingViewController: self.navigationController)
        createTourWelcomeFlowCoordinator?.start()
    }
}

extension HomePageFlowCoordinator: TourDetailFlowCoordinatorDelegate {
    
}

extension HomePageFlowCoordinator: CreateTourWelcomeFlowCoordinatorDelegate {
    
    func createTourWelcomeFlowDidFinish() {
        createTourWelcomeFlowCoordinator = nil
    }
}
