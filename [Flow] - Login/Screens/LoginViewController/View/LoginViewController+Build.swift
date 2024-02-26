//
//  LoginViewController+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 25.01.2024.
//

import Foundation
import UIKit
import Swinject

extension LoginViewController {
    
    static func build(coordinator: LoginInteractorCoordinatorDelegate, authService: AuthServiceProtocol, userService: UserServiceProtocol) -> UIViewController {
        let presenter = LoginPresenter()
        let interactor = LoginInteractor(presenter: presenter, authService: authService, userService: userService)
        interactor.coordinator = coordinator
        let viewController = LoginViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
