//
//  RegisterViewController+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 27.02.2024.
//

import Foundation
import UIKit

extension RegisterViewController {
    static func build(coordinator: RegisterInteractorCoordinatorDelegate, authService: AuthServiceProtocol) -> UIViewController {
        let presenter = RegisterPresenter()
        let interactor = RegisterInteractor(presenter: presenter, authService: authService)
        interactor.coordinator = coordinator
        let viewController = RegisterViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
