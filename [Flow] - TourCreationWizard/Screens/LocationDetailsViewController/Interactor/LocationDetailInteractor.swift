//
//  LocationDetailInteractor.swift
//  TourApp
//
//  Created by Cagatay Ceker on 16.03.2024.
//

import Foundation

protocol LocationDetailInteractorProtocol {
    func viewDidLoad()
    func didTapAddLocationButton(title: String, meetingTime: String)
}

protocol LocationDetailInteractorCoordinatorDelegate: AnyObject {
    func locationDetailInteractorDidTapAddLocationButton(tourId: String)
}

final class LocationDetailInteractor {
    
    weak var coordinator: LocationDetailInteractorCoordinatorDelegate?
    private let presenter: LocationDetailPresenterProtocol
    private let tourService: TourServiceProtocol
    private let dayId: String
    private let address: String
    
    init(presenter: LocationDetailPresenterProtocol, tourService: TourServiceProtocol, dayId: String, address: String) {
        self.presenter = presenter
        self.tourService = tourService
        self.dayId = dayId
        self.address = address
    }
}

extension LocationDetailInteractor: LocationDetailInteractorProtocol {
    
    func viewDidLoad() {
        presenter.presentViewDidLoad(address: address)
    }
    
    func didTapAddLocationButton(title: String, meetingTime: String) {
        tourService.postLocations(dayId: dayId, title: title, meetingTime: meetingTime) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.coordinator?.locationDetailInteractorDidTapAddLocationButton(tourId: response.id)
                case .failure(let failure):
                    break
                }
            }
        }
    }
}
