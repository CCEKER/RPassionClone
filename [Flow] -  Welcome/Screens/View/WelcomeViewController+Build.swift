//
//  WelcomeViewController+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 26.02.2024.
//

import Foundation
import UIKit

extension WelcomeViewController {
    static func build(coordinator: WelcomeInteractorCoordinatorDelegate) -> UIViewController {
        let presenter = WelcomePresenter()
        let interactor = WelcomeInteractor(presenter: presenter)
        interactor.coordinator = coordinator
        let viewController = WelcomeViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
