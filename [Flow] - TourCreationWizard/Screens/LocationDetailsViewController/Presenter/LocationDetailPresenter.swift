//
//  LocationDetailPresenter.swift
//  TourApp
//
//  Created by Cagatay Ceker on 16.03.2024.
//

import Foundation
import UIKit

protocol LocationDetailPresenterProtocol {
    func presentViewDidLoad(address: String)
}

final class LocationDetailPresenter: LocationDetailPresenterProtocol {
    
    weak var viewController: LocationDetailViewControllerProtocol?
    
    func presentViewDidLoad(address: String) {
        
        let viewModel = LocationDetailViewModel(
            selectedLocationTitle: "Selected Location",
            locationTtile: address,
            locationIcon: UIImage(named: "white-location")!,
            locationDetailsTitle: "Location Details",
            locationDetailsSubtitle: "Please give location a name. Choose what time to meet at this location.",
            textFieldPlaceHolder: "Location Name",
            datePickerLabelText: "Meeting time",
            addLocationButtonTitle: "Add Location",
            chevronIcon: UIImage(named: "chevron")!
        )
        viewController?.displayViewState(.initial(viewModel))
    }
}
