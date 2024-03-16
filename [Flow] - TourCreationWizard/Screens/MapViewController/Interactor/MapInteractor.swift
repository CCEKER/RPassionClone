//
//  MapInteractor.swift
//  TourApp
//
//  Created by Cagatay Ceker on 16.03.2024.
//

import Foundation

protocol MapInteractorProtocol {
    func viewDidLoad()
}

protocol MapInteractorCoordinatorDelegate: AnyObject {
    
}

final class MapInteractor {
    
    private let presenter: MapPresenterProtocol
    weak var coordinator: MapInteractorCoordinatorDelegate?
    private let tourService: TourServiceProtocol
    
    init(presenter: MapPresenterProtocol, tourService: TourServiceProtocol) {
        self.presenter = presenter
        self.tourService = tourService
    }
}

extension MapInteractor: MapInteractorProtocol {
    
    func viewDidLoad() {
        presenter.presentViewState()
    }
}
