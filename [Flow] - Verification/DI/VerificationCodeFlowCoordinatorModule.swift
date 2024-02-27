//
//  VerificationCodeFlowCoordinatorModule.swift
//  TourApp
//
//  Created by Cagatay Ceker on 27.02.2024.
//

import Foundation
import Swinject

protocol VerificationFlowCoordinatorResolver {
    func resolveVerificationViewController(delegate: VerificationCodeInteractorCoordinatorDelegate, email: String) -> UIViewController
}

final class VerificationCodeFlowCoordinatorModule: VerificationFlowCoordinatorResolver {
    
    private let resolver: Resolver
    private let container: Container
    
    init(parentContainer: Container) {
        container = Container(parent: parentContainer)
        _ = Assembler([VerificationCodeFlowCoordinatorAssembly()], container: container)
        self.resolver = container
    }
    
    func resolveVerificationViewController(delegate: VerificationCodeInteractorCoordinatorDelegate, email: String) -> UIViewController {
        
        guard let authService = resolver.resolve(AuthServiceProtocol.self) else {
            fatalError("LoginServiceProtocol should be registered")
        }
        guard let userService = resolver.resolve(UserServiceProtocol.self) else {
            fatalError("UserServiceProtocol should be registered")
        }
        return VerificationCodeViewController.build(coordinator: delegate, userService: userService, authService: authService, email: email)
    }
}
