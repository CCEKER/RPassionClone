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
    func resolveMyGarageFlowCoordinator(tabBarController: UITabBarController, delegate: GarageFlowCoordinatorDelegate) -> GarageFlowCoordinatorProtocol
}

final class DashboardFlowCoordinatorModule: DashboardFlowCoordinatorResolver {
    
    private let container: Container
    
    init(parentContainer: Container) {
        container = Container(parent: parentContainer)
        _ = Assembler([DashboardFlowCoordinatorAssembly()], container: container)
    }
    
    func resolveHomePageFlowCoordinator(tabBarController: UITabBarController, delegate: HomePageFlowCoordinatorDelegate) -> HomePageFlowCoordinatorProtocol {
        HomePageFlowCoordinator.build(tabBarController: tabBarController, delegate: delegate, container: container)
    }
    
    func resolveProfileFlowCoordinator(tabBarController: UITabBarController, delegate: ProfileFlowCoordinatorDelegate) -> ProfileFlowCoordinatorProtocol {
        ProfileFlowCoordinator.build(tabBarController: tabBarController, delegate: delegate, container: container)
    }
    
    func resolveMyGarageFlowCoordinator(tabBarController: UITabBarController, delegate: GarageFlowCoordinatorDelegate) -> GarageFlowCoordinatorProtocol {
        GarageFlowCoordinator.build(tabBarController: tabBarController, delegate: delegate, container: container)
    }
}
