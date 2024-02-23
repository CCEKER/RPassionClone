//
//  MyGarageFlowCoordinator+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import Foundation
import Swinject
import UIKit

extension MyGarageFlowCoordinator {
    static func build(tabBarController: UITabBarController, delegate: MyGarageFlowCoordinatorDelegate, container: Container) -> MyGarageFlowCoordinatorProtocol {
        let module = MyGarageFlowCoordinatorModule(parentContainer: container)
        return MyGarageFlowCoordinator(tabBarController: tabBarController, delegate: delegate, resolver: module)
    }
}
