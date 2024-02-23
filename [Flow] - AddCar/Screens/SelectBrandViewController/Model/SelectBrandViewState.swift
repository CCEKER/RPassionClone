//
//  SelectBrandViewState.swift
//  TourApp
//
//  Created by Cagatay Ceker on 13.02.2024.
//

import Foundation

enum SelectBrandViewState {
    case list([SelectionTableViewCellModel])
    case loading
    case error (ErrorViewModel)
}

struct SelectionTableViewCellModel {
    let id: String
    let title: String
    let image: String?
    let key: String?
}
