//
//  DashboardFlowCoordinatorModule.swift
//  TourApp
//
//  Created by Cagatay Ceker on 31.01.2024.
//

import Foundation
import Swinject

protocol DashboardFlowCoordinatorResolver {
    func resolveHomePageFlowCoordinator(tabBarController: UITabBarController, delegate: HomePageFlowCoordinatorDelegate) -> HomePageFlowCoordinatorProtocol
    func resolveProfileFlowCoordinator(tabBarController: UITabBarController, delegate: ProfileFlowCoordinatorDelegate) -> ProfileFlowCoordinatorProtocol
    func resolveGarageFlowCoordinator(tabBarController: UITabBarController, delegate: GarageFlowCoordinatorDelegate) -> GarageFlowCoordinatorProtocol
}

final class DashboardFlowCoordinatorModule: DashboardFlowCoordinatorResolver {
    
    private let container: Container
    private let resolver: Resolver
    

    init(parentContainer: Container) {
        container = Container(parent: parentContainer)
        _ = Assembler([DashboardFlowCoordinatorAssembly()], container: container)
        self.resolver = container
    }
    
    func resolveHomePageFlowCoordinator(tabBarController: UITabBarController, delegate: HomePageFlowCoordinatorDelegate) -> HomePageFlowCoordinatorProtocol {
        HomePageFlowCoordinator.build(tabBarController: tabBarController, delegate: delegate, container: container)
    }
    
    func resolveProfileFlowCoordinator(tabBarController: UITabBarController, delegate: ProfileFlowCoordinatorDelegate) -> ProfileFlowCoordinatorProtocol {
        ProfileFlowCoordinator.build(tabBarController: tabBarController, delegate: delegate, container: container)
    }
    
    func resolveGarageFlowCoordinator(tabBarController: UITabBarController, delegate: GarageFlowCoordinatorDelegate) -> GarageFlowCoordinatorProtocol {
		let userService = resolver.resolve(UserServiceProtocol.self)!
        guard let driverId = userService.user?.id else {
			fatalError("user must be logged in")
		}
        return GarageFlowCoordinator.build(startMode: .toTabBar(tabBarController), delegate: delegate, driverId: driverId, container: container)
    }
}
