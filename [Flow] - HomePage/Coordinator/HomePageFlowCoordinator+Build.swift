//
//  HomePageFlowCoordinator+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 31.01.2024.
//

import Foundation
import Swinject
import UIKit

extension HomePageFlowCoordinator {
    static func build(tabBarController: UITabBarController, delegate: HomePageFlowCoordinatorDelegate, container: Container) -> HomePageFlowCoordinatorProtocol {
        let module = HomePageFlowCoordinatorModule(parentContainer: container)
        return HomePageFlowCoordinator(tabBarController: tabBarController, delegate: delegate, resolver: module)
    }
}
