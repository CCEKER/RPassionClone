//
//  MyGarageViewController+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import Foundation
import UIKit

extension MyGarageViewController {
    static func build(coordinator: MyGarageInteractorCoordinatorDelegate, carService: CarServiceProtocol, userId: String) -> MyGarageViewController {
        let presenter = MyGaragePresenter()
        let interactor = MyGarageInteractor(presenter: presenter, carService: carService, userId: userId)
        interactor.coordinator = coordinator
        let viewController = MyGarageViewController(interactor: interactor)
        viewController.tabBarItem.title = "My Garage"
        viewController.tabBarItem.image = UIImage(named: "garage")
        let apparance = UITabBarAppearance()
        apparance.configureWithOpaqueBackground()
        apparance.backgroundColor = .background
        UITabBar.appearance().standardAppearance = apparance
        UITabBar.appearance().scrollEdgeAppearance = apparance
        presenter.viewController = viewController
        return viewController
    }
}
