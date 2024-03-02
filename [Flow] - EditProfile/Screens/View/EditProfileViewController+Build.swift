//
//  EditProfileViewController+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 2.03.2024.
//

import Foundation
import UIKit

extension EditProfileViewController {
    static func build(coordinator: EditProfileInteractorCoordinatorDelegate, authService: AuthServiceProtocol, userService: UserServiceProtocol) -> UIViewController {
        let presenter = EditProfilePresenter()
        let interactor = EditProfileInteractor(presenter: presenter, authService: authService, userService: userService)
        interactor.coordinator = coordinator
        let viewController = EditProfileViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
