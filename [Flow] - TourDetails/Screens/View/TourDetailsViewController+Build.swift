//
//  TourDetailsViewController+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 8.02.2024.
//

import Foundation
import UIKit

extension TourDetailsViewController {
    static func build(coordinator: TourDetailsInteractorCoordinatorDelegate, tourDetailService: TourServiceProtocol, tourId: String) -> UIViewController {
        let presenter = TourDetailsPresenter()
        let interactor = TourDetailsInteractor(presenter: presenter, tourDetailService: tourDetailService, tourId: tourId)
        interactor.coordinator = coordinator
        let viewController = TourDetailsViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
