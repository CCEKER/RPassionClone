//
//  HomePageViewController+Build.swift
//  TourApp
//
//  Created by Cagatay Ceker on 5.01.2024.
//

import UIKit

extension HomePageViewContoller {
    
    static func build(coordinator: HomePageInteractorCoordinatorDelegate, homePageService: HomePageServiceProtocol) -> UIViewController {
        let presenter = HomePagePresenter()
        let interactor = HomePageInteractor(presenter: presenter, homePageService: homePageService)
        interactor.coordinator = coordinator
        let viewController = HomePageViewContoller(interactor: interactor)
        viewController.tabBarItem.title = "Home"
        viewController.tabBarItem.image = UIImage(named: "Tours")
        presenter.viewController = viewController
        return viewController
    }
}
