//
//  MapViewState.swift
//  TourApp
//
//  Created by Cagatay Ceker on 16.03.2024.
//

import Foundation

enum MapViewState {
    case inital(MapViewModel)
    case loading
    case error(ErrorViewModel)
}

struct MapViewModel {
    let navigationTitle: String
    let checkAddressButtonTitle: String
}
