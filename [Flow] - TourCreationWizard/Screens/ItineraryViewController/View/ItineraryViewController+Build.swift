//
//  ItineraryViewController+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 14.03.2024.
//

import Foundation
import UIKit

extension ItineraryViewController {
    static func build(coordinator: ItineraryInteractorCoordinatorDelegate, tourId: String, tourService: TourServiceProtocol) -> UIViewController {
        let presenter = ItineraryPresenter()
        let interactor = ItineraryInteractor(presenter: presenter, tourId: tourId, tourService: tourService)
        interactor.coordinator = coordinator
        let viewController = ItineraryViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
