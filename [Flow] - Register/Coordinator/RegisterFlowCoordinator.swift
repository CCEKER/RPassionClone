//
//  RegisterFlowCoordinator.swift
//  TourApp
//
//  Created by Cagatay Ceker on 27.02.2024.
//

import Foundation
import UIKit

protocol RegisterFlowCoordinatorProtocol {
    func start()
}

protocol RegisterFlowCoordinatorDelegate {
    func registerFlowCoordinatorDidFinish()
    func verificationCodeFlowDidFinish()
}

final class RegisterFlowCoordinator: RegisterFlowCoordinatorProtocol {
    
    private let window: UIWindow
    private let delegate: RegisterFlowCoordinatorDelegate
    private var navigationController = UINavigationController()
    private let resolver: RegisterFlowCoordinatorResolver
    private var verificationCodeFlowCoordinator: VerificationCodeFlowCoordinatorProtocol?
    
    init(window: UIWindow, delegate: RegisterFlowCoordinatorDelegate, resolver: RegisterFlowCoordinatorResolver) {
        self.window = window
        self.delegate = delegate
        self.resolver = resolver
    }
    
    func start() {
        let registerViewController = resolver.resolveRegisterViewController(delegate: self)
        let navigationController = UINavigationController(rootViewController: registerViewController)
        self.navigationController = navigationController
        self.window.rootViewController = navigationController
    }
}

extension RegisterFlowCoordinator: RegisterInteractorCoordinatorDelegate {
    
    func registerInteractorDidTapBackLoginButton() {
        delegate.registerFlowCoordinatorDidFinish()
    }
    
    func registerInteractorDidTapNextButton(email: String) {
        verificationCodeFlowCoordinator = resolver.resolveVerificationFlowCoordinator(delegate: self, presentingViewController: self.navigationController, email: email)
        verificationCodeFlowCoordinator?.start()
    }
}

extension RegisterFlowCoordinator: VerificationCodeFlowCoordinatorDelegate {
   
    func verificationFlowDidFinish() {
        delegate.verificationCodeFlowDidFinish()
    }
}
