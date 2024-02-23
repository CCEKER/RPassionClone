//
//  SelectedCarViewState.swift
//  TourApp
//
//  Created by Cagatay Ceker on 16.02.2024.
//

import Foundation

enum SelectedCarViewState {
    case initial(SelectedCarViewModel)
    case loading
    case error(ErrorViewModel)
}

struct SelectedCarViewModel {
    let makerTitle: String
    let makerModelTitle: String
    let makerModelTrimTitle: String
    var imageUrl: String?
}
