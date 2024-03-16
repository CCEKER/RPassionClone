//
//  LocationDetailViewModel.swift
//  TourApp
//
//  Created by Cagatay Ceker on 16.03.2024.
//

import Foundation
import UIKit

struct LocationDetailViewModel {
    let selectedLocationTitle: String
    let locationTtile: String
    let locationIcon: UIImage
    let locationDetailsTitle: String
    let locationDetailsSubtitle: String
    let textFieldPlaceHolder: String
    let datePickerLabelText: String
    let addLocationButtonTitle: String
    let chevronIcon: UIImage
}

enum LocationDetailViewState {
    case initial(LocationDetailViewModel)
    case loading
    case error(ErrorViewModel)
}
