//
//  VerificationCodeFlowCoordinator+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 27.02.2024.
//

import Foundation
import Swinject

extension VerificationCodeFlowCoordinator {
    static func build(delegate: VerificationCodeFlowCoordinatorDelegate, container: Container, presentingViewController: UINavigationController, email: String) -> VerificationCodeFlowCoordinatorProtocol {
        let module = VerificationCodeFlowCoordinatorModule(parentContainer: container)
        return VerificationCodeFlowCoordinator(delegate: delegate, resolver: module, presentingViewController: presentingViewController, email: email)
    }
}
