//
//  EditProfileFlowCoordinatorModule.swift
//  TourApp
//
//  Created by Cagatay Ceker on 2.03.2024.
//

import Foundation
import Swinject

protocol EditProfileFlowCoordinatorResolver {
    func resolveEditProfileViewController(delegate: EditProfileInteractorCoordinatorDelegate) -> UIViewController
}

final class EditProfileFlowCoordinatorModule: EditProfileFlowCoordinatorResolver {
    
    private let container: Container
    private let resolver: Resolver
    
    init(parentContainer: Container) {
        container = Container(parent: parentContainer)
        _ = Assembler([EditProfileFlowCoordinatorAssembly()], container: container)
        self.resolver = container
    }
    
    func resolveEditProfileViewController(delegate: EditProfileInteractorCoordinatorDelegate) -> UIViewController {
        guard let authService = resolver.resolve(AuthServiceProtocol.self) else {
            fatalError("AuthServiceProtocol should be registered")
        }
        return EditProfileViewController.build(coordinator: delegate, authService: authService)
    }
}
