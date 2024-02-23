//
//  AddCarFlowCoordinator+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import Foundation
import UIKit
import Swinject

extension AddCarFlowCoordinator {
    static func build(delegate: AddCarFlowCoordinatorDelegate, container: Container, presentingViewController: UINavigationController) -> AddCarFlowCoordinatorProtocol {
        let module = AddCarFlowCoordinatorModule(parentContainer: container)
        return AddCarFlowCoordinator(delegate: delegate, resolver: module, presentingViewController: presentingViewController)
    }
}
