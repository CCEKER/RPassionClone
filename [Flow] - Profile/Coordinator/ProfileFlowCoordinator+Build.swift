//
//  ProfileFlowCoordinator+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 31.01.2024.
//

import Foundation
import Swinject
import UIKit

extension ProfileFlowCoordinator {
    static func build(tabBarController: UITabBarController, delegate: ProfileFlowCoordinatorDelegate, container: Container) -> ProfileFlowCoordinatorProtocol {
        let module = ProfileFlowCoordinatorModule(parentContainer: container)
        return ProfileFlowCoordinator(tabBarController: tabBarController, delegate: delegate, resolver: module)
    }
}
