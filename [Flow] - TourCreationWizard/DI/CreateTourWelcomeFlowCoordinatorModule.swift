//
//  CreateTourWelcomeFlowCoordinatorModule.swift
//  TourApp
//
//  Created by Cagatay Ceker on 11.03.2024.
//

import Foundation
import Swinject

protocol CreateTourWelcomeFlowCoordinatorResolver {
    func resolveCreateTourWelcomeFlowCoordinator(delegate: CreateTourWelcomeInteractorCoordinatorDelegate) -> UIViewController
    func resolveCreateTourViewController(delegate: CreateTourInteractorCoordinatorDelegate) -> UIViewController
    func resolveTourTimeViewController(delegate: TourTimeInteractorCoordinatorDelegate, tourId: String) -> UIViewController
    func resolveItineraryViewController(delegate: ItineraryInteractorCoordinatorDelegate, tourId: String) -> UIViewController
    func resolveMapViewController(delegate: MapInteractorCoordinatorDelegate) -> UIViewController
    func resolveLocationDetailViewController(delegate: LocationDetailInteractorCoordinatorDelegate, dayId: Int, address: String) -> UIViewController
}

final class CreateTourWelcomeFlowCoordinatorModule: CreateTourWelcomeFlowCoordinatorResolver {
    
    private let container: Container
    private let resolver: Resolver
    
    init(parentContainer: Container) {
        container = Container(parent: parentContainer)
        _ = Assembler([CreateTourWelcomeFlowCoordinatorAssembly()], container: container)
        self.resolver = container
    }
    
    func resolveCreateTourWelcomeFlowCoordinator(delegate: CreateTourWelcomeInteractorCoordinatorDelegate) -> UIViewController {
       CreateTourWelcomeViewController.build(coordinator: delegate)
    }
    
    func resolveCreateTourViewController(delegate: CreateTourInteractorCoordinatorDelegate) -> UIViewController {
        guard let tourService = resolver.resolve(TourServiceProtocol.self) else {
            fatalError("TourServiceProtocol must be registered.")
        }
        return CreateTourViewController.build(coordinator: delegate, tourService: tourService)
    }
    
    func resolveTourTimeViewController(delegate: TourTimeInteractorCoordinatorDelegate, tourId: String) -> UIViewController {
        guard let tourService = resolver.resolve(TourServiceProtocol.self) else {
            fatalError("TourServiceProtocol must be registered.")
        }
        return TourTimeViewController.build(coordinator: delegate, tourId: tourId, tourService: tourService)
    }
    
    func resolveItineraryViewController(delegate: ItineraryInteractorCoordinatorDelegate, tourId: String) -> UIViewController {
        guard let tourService = resolver.resolve(TourServiceProtocol.self) else {
            fatalError("TourServiceProtocol must be registered.")
        }
        return ItineraryViewController.build(coordinator: delegate, tourId: tourId, tourService: tourService)
    }
    
    func resolveMapViewController(delegate: MapInteractorCoordinatorDelegate) -> UIViewController {
        guard let tourService = resolver.resolve(TourServiceProtocol.self) else {
            fatalError("TourServiceProtocol must be registered.")
        }
        return MapViewController.build(coordinator: delegate, tourService: tourService)
    }
    
    func resolveLocationDetailViewController(delegate: LocationDetailInteractorCoordinatorDelegate, dayId: Int, address: String) -> UIViewController {
        guard let tourService = resolver.resolve(TourServiceProtocol.self) else {
            fatalError("TourServiceProtocol must be registered.")
        }
        return LocationDetailViewController.build(coordinator: delegate, tourService: tourService, dayId: dayId, address: address)
    }
}
