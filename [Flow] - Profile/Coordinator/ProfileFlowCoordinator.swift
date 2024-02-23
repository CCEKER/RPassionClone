//
//  ProfileFlowCoordinator.swift
//  TourApp
//
//  Created by Cagatay Ceker on 26.01.2024.
//

import Foundation
import UIKit

protocol ProfileFlowCoordinatorProtocol {
    func start()
}

protocol ProfileFlowCoordinatorDelegate: AnyObject {
    func profileFlowCoordinatorDidFinish()
}

final class ProfileFlowCoordinator: ProfileFlowCoordinatorProtocol {
    
    private let tabBarController: UITabBarController
    private let delegate: ProfileFlowCoordinatorDelegate
    private var navigationController = UINavigationController()
    private var resolver: ProfileFlowCoordinatorResolver

    init(tabBarController: UITabBarController, delegate: ProfileFlowCoordinatorDelegate, resolver: ProfileFlowCoordinatorResolver) {
        self.tabBarController = tabBarController
        self.delegate = delegate
        self.resolver = resolver
    }
    
    func start() {
        let profileViewController = resolver.resolveProfileViewController(coordinator: self)
        let navigationController = UINavigationController(rootViewController: profileViewController)
        self.navigationController = navigationController
    
        if tabBarController.viewControllers == nil {
            tabBarController.viewControllers = [navigationController]
        } else {
            tabBarController.viewControllers?.append(navigationController)
        }
    }
}

extension ProfileFlowCoordinator: ProfileInteractorCoordinatorDelegate {
    
    func profileInteractorDidTapLogoutButton() {
        delegate.profileFlowCoordinatorDidFinish()
    }
}
