//
//  WelcomeFlowCoordinator.swift
//  TourApp
//
//  Created by Cagatay Ceker on 26.02.2024.
//

import Foundation
import UIKit

protocol WelcomeFlowCoordinatorProtocol {
    func start()
}

protocol WelcomeFlowCoordinatorDelegate {
    func welcomeFlowCoordinatorDidFinish()
}

final class WelcomeFlowCoordinator: WelcomeFlowCoordinatorProtocol {
    
    private let window: UIWindow
    private let delegate: WelcomeFlowCoordinatorDelegate
    private var navigationController = UINavigationController()
    private let resolver: WelcomeFlowCoordinatorResolver
    
    init(window: UIWindow, delegate: WelcomeFlowCoordinatorDelegate, resolver: WelcomeFlowCoordinatorResolver) {
        self.window = window
        self.delegate = delegate
        self.resolver = resolver
    }
    
    func start() {
        let welcomeViewController = resolver.resolveWelcomeViewController(delegate: self)
        navigationController.viewControllers = [welcomeViewController]
        self.window.rootViewController = navigationController
    }
}

extension WelcomeFlowCoordinator: WelcomeInteractorCoordinatorDelegate {
    
    func welcomeFlowDidTapStartButton() {
        delegate.welcomeFlowCoordinatorDidFinish()
    }
}
