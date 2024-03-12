//
//  CreateTourViewModel.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.03.2024.
//

import Foundation

enum CreateTourViewState {
    case initial(CreateTourViewModel)
    case loading
    case error(ErrorViewModel)
}

struct CreateTourViewModel {
    let navigationTitle: String
    let tourNameTextFieldPlaceHolder: String
    let tourDescriptionText: String
    let continueButtonTitleLabel: String
}
