//
//  GarageViewState.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import Foundation

enum GarageViewState {
    case list([CarTableViewCellModel])
    case loading
    case empty(GarageEmptyViewModel)
    case error(ErrorViewModel)
}

struct CarTableViewCellModel {
    let id: String
    let image: String?
    let title: String
    let subTitle: String
}

struct GarageEmptyViewModel {
    let title: String
    let description: String
    let actionButtonTitle: String
}
