//
//  TourDetailsFlowCoordinator+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 8.02.2024.
//

import Foundation
import Swinject
import UIKit

extension TourDetailFlowCoordinator {
    static func build(delegate: TourDetailFlowCoordinatorDelegate, container: Container, tourId: String, presentingViewController: UINavigationController) -> TourDetailFlowCoordinatorProtocol {
        let module = TourDetailFlowCoordinatorModule(parentContainer: container)
        return TourDetailFlowCoordinator(delegate: delegate, resolver: module, tourId: tourId, presentingViewController: presentingViewController)
    }
}
