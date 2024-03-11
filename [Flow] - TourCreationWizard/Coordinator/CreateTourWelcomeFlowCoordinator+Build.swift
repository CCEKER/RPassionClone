//
//  CreateTourWelcomeFlowCoordinator+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 11.03.2024.
//

import Foundation
import Swinject
import UIKit

extension CreateTourWelcomeFlowCoordinator {
    static func build(delegate: CreateTourWelcomeFlowCoordinatorDelegate, container: Container, presentingViewController: UINavigationController) -> CreateTourWelcomeFlowCoordinatorProtocol {
        let module = CreateTourWelcomeFlowCoordinatorModule(parentContainer: container)
        return CreateTourWelcomeFlowCoordinator(delegate: delegate, resolver: module, presentingViewController: presentingViewController)
    }
}
