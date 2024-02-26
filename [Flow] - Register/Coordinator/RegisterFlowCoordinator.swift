//
//  RegisterFlowCoordinator.swift
//  TourApp
//
//  Created by Cagatay Ceker on 27.02.2024.
//

import Foundation
import UIKit

protocol RegisterFlowCoordinatorProtocol {
    func start()
}

protocol RegisterFlowCoordinatorDelegate {
    
}

final class RegisterFlowCoordinator: RegisterFlowCoordinatorProtocol {
    
    private let window: UIWindow
    private let delegate: RegisterFlowCoordinatorDelegate
    private var navigationController = UINavigationController()
    private let resolver: RegisterFlowCoordinatorResolver
    
    init(window: UIWindow, delegate: RegisterFlowCoordinatorDelegate, resolver: RegisterFlowCoordinatorResolver) {
        self.window = window
        self.delegate = delegate
        self.resolver = resolver
    }
    
    func start() {
        let registerViewController = resolver.resolveRegisterViewController(delegate: self)
        navigationController.viewControllers = [registerViewController]
        self.window.rootViewController = navigationController
    }
}

extension RegisterFlowCoordinator: RegisterInteractorCoordinatorDelegate {
    
}
