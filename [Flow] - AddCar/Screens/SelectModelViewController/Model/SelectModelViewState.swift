//
//  SelectModelViewState.swift
//  TourApp
//
//  Created by Cagatay Ceker on 16.02.2024.
//

import Foundation

enum SelectModelViewState {
    case list([SelectModelViewModel])
    case loading
    case error(ErrorViewModel)
}

struct SelectModelViewModel {
    let title: String
    let key: String
    let id: String
}
