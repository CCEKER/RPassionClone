//
//  VerificationCodeFlowCoordinator.swift
//  TourApp
//
//  Created by Cagatay Ceker on 27.02.2024.
//

import Foundation
import UIKit

protocol VerificationCodeFlowCoordinatorProtocol {
    func start()
}

protocol VerificationCodeFlowCoordinatorDelegate {
    func verificationFlowDidFinish()
}

final class VerificationCodeFlowCoordinator: VerificationCodeFlowCoordinatorProtocol {
    
    private let delegate: VerificationCodeFlowCoordinatorDelegate
    private let resolver: VerificationFlowCoordinatorResolver
    private let presentingViewController: UINavigationController
    private var email: String
    
    init(delegate: VerificationCodeFlowCoordinatorDelegate, resolver: VerificationFlowCoordinatorResolver, presentingViewController: UINavigationController, email: String) {
        self.delegate = delegate
        self.resolver = resolver
        self.presentingViewController = presentingViewController
        self.email = email
    }
    func start() {
        let verificationCodeViewController = resolver.resolveVerificationViewController(delegate: self, email: email)
        presentingViewController.pushViewController(verificationCodeViewController, animated: true)
    }
}

extension VerificationCodeFlowCoordinator: VerificationCodeInteractorCoordinatorDelegate {
    
    func didTapInteractorConfirmButton() {
        delegate.verificationFlowDidFinish()
    }
}
