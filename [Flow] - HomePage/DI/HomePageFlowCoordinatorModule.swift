//
//  HomePageFlowCoordinatorModule.swift
//  TourApp
//
//  Created by Cagatay Ceker on 31.01.2024.
//

import Foundation
import Swinject
import UIKit

protocol HomePageFlowCoordinatorResolver {
    func resolveHomePageViewController(coordinator: HomePageInteractorCoordinatorDelegate) -> UIViewController
    func resolveTourDetailFlow(delegate: TourDetailFlowCoordinatorDelegate, presenting: UINavigationController, tourId: String) -> TourDetailFlowCoordinatorProtocol
    func resolveCreateTourWelcomeFlowCoordinator(delegate: CreateTourWelcomeFlowCoordinatorDelegate, presentingViewController: UINavigationController) -> CreateTourWelcomeFlowCoordinatorProtocol
}

final class HomePageFlowCoordinatorModule: HomePageFlowCoordinatorResolver {
    
    private let container: Container
    private let resolver: Resolver
    
    init(parentContainer: Container) {
        container = Container(parent: parentContainer)
        _ = Assembler([HomePageFlowCoordinatorAssembly()], container: container)
        self.resolver = container
    }
    
    func resolveHomePageViewController(coordinator: HomePageInteractorCoordinatorDelegate) -> UIViewController {
        guard let homePageService = resolver.resolve(HomePageServiceProtocol.self) else {
            fatalError("HomePageServiceProtocol should be registered!")
        }
        return HomePageViewContoller.build(coordinator: coordinator, homePageService: homePageService)
    }
    
    func resolveTourDetailFlow(delegate: TourDetailFlowCoordinatorDelegate, presenting: UINavigationController, tourId: String) -> TourDetailFlowCoordinatorProtocol {
        let tourDetailFlowCoordinator = TourDetailFlowCoordinator.build(delegate: delegate, container: container, tourId: tourId, presentingViewController: presenting)
        return tourDetailFlowCoordinator
    }
    
    func resolveCreateTourWelcomeFlowCoordinator(delegate: CreateTourWelcomeFlowCoordinatorDelegate, presentingViewController: UINavigationController) -> CreateTourWelcomeFlowCoordinatorProtocol {
        let createTourWelcomeFlowCoordinator = CreateTourWelcomeFlowCoordinator.build(delegate: delegate, container: container, presentingViewController: presentingViewController)
        return createTourWelcomeFlowCoordinator
    }
}
