//
//  LoginFlowCoordinatorModule.swift
//  TourApp
//
//  Created by Cagatay Ceker on 31.01.2024.
//

import Foundation
import Swinject

protocol LoginFlowCoordinatorResolver {
    func resolveLoginViewController(delegate: LoginInteractorCoordinatorDelegate) -> UIViewController
}

final class LoginFlowCoordinatorModule: LoginFlowCoordinatorResolver {
    
    private let container: Container
    private let resolver: Resolver
    
    init(parentContainer: Container) {
        container = Container(parent: parentContainer)
        _ = Assembler([LoginFlowCoordinatorAssembly()], container: container)
        
        self.resolver = container
    }
    
    func resolveLoginViewController(delegate: LoginInteractorCoordinatorDelegate) -> UIViewController {
        guard let loginService = resolver.resolve(LoginServiceProtocol.self) else {
            fatalError("LoginServiceProtocol should be registered")
        }
        guard let userService = resolver.resolve(UserServiceProtocol.self) else {
            fatalError("UserServiceProtocol should be registered")
        }
        return LoginViewController.build(coordinator: delegate, loginService: loginService, userService: userService)
    }
}
