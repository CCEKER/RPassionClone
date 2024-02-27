//
//  VerificationCodeViewController+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 27.02.2024.
//

import Foundation
import UIKit

extension VerificationCodeViewController {
    static func build(coordinator: VerificationCodeInteractorCoordinatorDelegate, userService: UserServiceProtocol, authService: AuthServiceProtocol, email: String) -> UIViewController {
        let presenter = VerificationCodePresenter()
        let interactor = VerificationCodeInteractor(presenter: presenter, authService: authService, userService: userService, email: email)
        interactor.coordinator = coordinator
        let viewController = VerificationCodeViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
