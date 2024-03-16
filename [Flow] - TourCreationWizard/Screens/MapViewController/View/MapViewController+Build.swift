//
//  MapViewController+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 16.03.2024.
//

import Foundation
import UIKit

extension MapViewController {
    static func build(coordinator: MapInteractorCoordinatorDelegate, tourService: TourServiceProtocol, selectedDayId: String) -> UIViewController {
        let presenter = MapPresenter()
        let interactor = MapInteractor(presenter: presenter, tourService: tourService, selectedDayId: selectedDayId)
        interactor.coordinator = coordinator
        let viewController = MapViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
