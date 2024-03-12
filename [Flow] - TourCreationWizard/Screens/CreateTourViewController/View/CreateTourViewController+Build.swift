//
//  CreateTourViewController+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 11.03.2024.
//

import Foundation
import UIKit

extension CreateTourViewController {
    static func build(coordinator: CreateTourInteractorCoordinatorDelegate, tourService: TourServiceProtocol) -> UIViewController {
        let presenter = CreateTourPresenter()
        let interactor = CreateTourInteractor(presenter: presenter, tourService: tourService)
        interactor.coordinator = coordinator
        let viewController = CreateTourViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
