//
//  TourTimeViewController+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 13.03.2024.
//

import Foundation
import UIKit

extension TourTimeViewController {
    static func build(coordinator: TourTimeInteractorCoordinatorDelegate, tourId: String, tourService: TourServiceProtocol) -> UIViewController {
        let presenter = TourTimePresenter()
        let interactor = TourTimeInteractor(presenter: presenter, tourId: tourId, tourService: tourService)
        interactor.coordinator = coordinator
        let viewController = TourTimeViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
