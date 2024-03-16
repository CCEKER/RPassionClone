//
//  LocationDetailInteractor.swift
//  TourApp
//
//  Created by Cagatay Ceker on 16.03.2024.
//

import Foundation

protocol LocationDetailInteractorProtocol {
    func viewDidLoad()
}

protocol LocationDetailInteractorCoordinatorDelegate: AnyObject {
    
}

final class LocationDetailInteractor {
    
    weak var coordinator: LocationDetailInteractorCoordinatorDelegate?
    private let presenter: LocationDetailPresenterProtocol
    private let tourService: TourServiceProtocol
    private let dayId: Int
    private let address: String
    
    init(presenter: LocationDetailPresenterProtocol, tourService: TourServiceProtocol, dayId: Int, address: String) {
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
}
