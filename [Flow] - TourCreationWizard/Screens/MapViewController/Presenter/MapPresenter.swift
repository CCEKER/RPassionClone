//
//  MapPresenter.swift
//  TourApp
//
//  Created by Cagatay Ceker on 16.03.2024.
//

import Foundation

protocol MapPresenterProtocol {
    func presentViewState()
}

final class MapPresenter: MapPresenterProtocol {
    
    weak var viewController: MapViewControllerProtocol?
    
    func presentViewState() {
        
        let viewModel = MapViewModel(
            navigationTitle: "Add Location",
            checkAddressButtonTitle: "Check Address"
        )
        viewController?.displayViewState(.inital(viewModel))
    }
}
