//
//  LoginFlowCoordinator.swift
//  TourApp
//
//  Created by Cagatay Ceker on 25.01.2024.
//

import Foundation
import UIKit

protocol LoginFlowCoordinatorProtocol {
    func start()
}

protocol LoginFlowCoordinatorDelegate {
    func loginFlowCoordinatorDidFinish()
}

final class LoginFlowCoordinator: LoginFlowCoordinatorProtocol {
    
    private let window: UIWindow
    private let delegate: LoginFlowCoordinatorDelegate?
    private var navigationController = UINavigationController()
    private let resolver: LoginFlowCoordinatorResolver
    
    init(window: UIWindow, delegate: LoginFlowCoordinatorDelegate, resolver: LoginFlowCoordinatorResolver) {
        self.window = window
        self.delegate = delegate
        self.resolver = resolver
    }
    
    func start() {
        let loginViewController = resolver.resolveLoginViewController(delegate: self)
        navigationController.viewControllers = [loginViewController]
        self.window.rootViewController = navigationController
    }
}

extension LoginFlowCoordinator: LoginInteractorCoordinatorDelegate {
    
    func loginInteractorUserDidLogin() {
        delegate?.loginFlowCoordinatorDidFinish()
    }
}
