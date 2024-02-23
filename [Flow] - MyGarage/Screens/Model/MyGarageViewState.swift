//
//  MyGarageViewState.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import Foundation

enum MyGarageViewState {
    case list([CarTableViewCellModel])
    case loading
    case empty(MyGarageEmptyViewModel)
    case error(ErrorViewModel)
}

struct CarTableViewCellModel {
    let id: String
    let image: String?
    let title: String
    let subTitle: String
}

struct MyGarageEmptyViewModel {
    let title: String
    let description: String
    let actionButtonTitle: String
}
