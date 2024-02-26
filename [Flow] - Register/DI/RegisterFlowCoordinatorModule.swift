//
//  RegisterFlowCoordinatorModule.swift
//  TourApp
//
//  Created by Cagatay Ceker on 27.02.2024.
//

import Foundation
import Swinject

protocol RegisterFlowCoordinatorResolver {
    func resolveRegisterViewController(delegate: RegisterInteractorCoordinatorDelegate) -> UIViewController
}

final class RegisterFlowCoordinatorModule: RegisterFlowCoordinatorResolver {
    
    private let container: Container
    private let resolver: Resolver
    
    init(parentContainer: Container) {
        container = Container(parent: parentContainer)
        _ = Assembler([RegisterFlowCoordinatorAssembly()], container: container)
        self.resolver = container
    }
    
    func resolveRegisterViewController(delegate: RegisterInteractorCoordinatorDelegate) -> UIViewController {
        
        guard let authService = resolver.resolve(AuthServiceProtocol.self) else {
            fatalError("AuthServiceProtocol should be registered")
        }
        return RegisterViewController.build(coordinator: delegate, authService: authService)
    }
}
