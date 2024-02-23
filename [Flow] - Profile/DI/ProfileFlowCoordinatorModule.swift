//
//  ProfileFlowCoordinatorModule.swift
//  TourApp
//
//  Created by Cagatay Ceker on 31.01.2024.
//

import Foundation
import Swinject
import UIKit

protocol ProfileFlowCoordinatorResolver {
    func resolveProfileViewController(coordinator: ProfileFlowCoordinator) -> UIViewController
}

final class ProfileFlowCoordinatorModule: ProfileFlowCoordinatorResolver {
    
    private let resolver: Resolver
    private let container: Container
  
    init(parentContainer: Container) {
        container = Container(parent: parentContainer)
        _ = Assembler([ProfileFlowCoordinatorAssembly()], container: container)
        self.resolver = container
    }
    
    func resolveProfileViewController(coordinator: ProfileFlowCoordinator) -> UIViewController {
        let userService = resolver.resolve(UserServiceProtocol.self)!
        let profileViewController = ProfileViewController.build(coordinator: coordinator, userService: userService)
        return profileViewController
    }
}
