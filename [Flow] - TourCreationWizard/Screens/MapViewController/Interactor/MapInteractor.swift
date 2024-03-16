//
//  MapInteractor.swift
//  TourApp
//
//  Created by Cagatay Ceker on 16.03.2024.
//

import Foundation

protocol MapInteractorProtocol {
    func viewDidLoad()
    func didTapCheckAddressButton(latitude: Double, longitude: Double)
}

protocol MapInteractorCoordinatorDelegate: AnyObject {
    func mapInteractorDidTapCheckAddressButton()
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
    
    func didTapCheckAddressButton(latitude: Double, longitude: Double) {
        tourService.getLocation(latitude: latitude, longitude: longitude) { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let failure):
                break
            }
        }
    }
}
