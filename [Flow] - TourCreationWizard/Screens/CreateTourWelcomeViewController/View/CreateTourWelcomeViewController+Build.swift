//
//  CreateTourWelcomeViewController+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 11.03.2024.
//

import Foundation
import UIKit

extension CreateTourWelcomeViewController {
    static func build(coordinator: CreateTourWelcomeInteractorCoordinatorDelegate) -> UIViewController {
        let presenter = CreateTourWelcomePresenter()
        let interactor = CreateTourWelcomeInteractor(presenter: presenter)
        interactor.coordinator = coordinator
        let viewController = CreateTourWelcomeViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
