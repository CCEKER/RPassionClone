//
//  SelectTrimViewState.swift
//  TourApp
//
//  Created by Cagatay Ceker on 16.02.2024.
//

import Foundation

enum SelectTrimViewState {
    case list([TrimViewModel])
    case loading
    case error(ErrorViewModel)
}

struct TrimViewModel {
    let title: String
    let id: String
}
