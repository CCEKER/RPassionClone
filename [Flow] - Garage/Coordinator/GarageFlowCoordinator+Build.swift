//
//  GarageFlowCoordinator+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import Foundation
import Swinject
import UIKit

extension GarageFlowCoordinator {
    static func build(tabBarController: UITabBarController, delegate: GarageFlowCoordinatorDelegate, container: Container) -> GarageFlowCoordinatorProtocol {
        let module = GarageFlowCoordinatorModule(parentContainer: container)
        return GarageFlowCoordinator(tabBarController: tabBarController, delegate: delegate, resolver: module)
    }
}
