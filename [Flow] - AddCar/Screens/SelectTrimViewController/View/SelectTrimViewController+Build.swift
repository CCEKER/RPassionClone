//
//  SelectTrimViewController+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 16.02.2024.
//

import Foundation
import UIKit

extension SelectTrimViewController {
    static func build(coordinator: SelectTrimInteractorCoordinatorDelegate, key: String, brandService: BrandServiceProtocol) -> UIViewController {
        let presenter = SelectTrimPresenter()
        let interactor = SelectTrimInteractor(presenter: presenter, key: key, brandService: brandService)
        interactor.coordinator = coordinator
        let viewController = SelectTrimViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
