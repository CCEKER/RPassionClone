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
	
	enum StartMode {
		case toTabBar(UITabBarController)
		case push(UINavigationController)
		case present(UIViewController)
	}
	
    static func build(startMode: StartMode, delegate: GarageFlowCoordinatorDelegate, driverId: String, container: Container) -> GarageFlowCoordinatorProtocol {
        let module = GarageFlowCoordinatorModule(parentContainer: container)
		return GarageFlowCoordinator(startMode: startMode, delegate: delegate, driverId: driverId, resolver: module)
    }
}
