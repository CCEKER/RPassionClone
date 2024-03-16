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
    func mapInteractorDidTapCheckAddressButton(dayId: Int, address: String)
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
        tourService.getLocation(latitude: latitude, longitude: longitude) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.coordinator?.mapInteractorDidTapCheckAddressButton(dayId: response.id, address: response.address)
                case .failure:
                    break
                }
            }
        }
    }
}
