//
//  ParticipantsViewModel.swift
//  TourApp
//
//  Created by Cagatay Ceker on 20.02.2024.
//

import Foundation

enum ParticipantsViewState {
    case list([ParticipantsViewModel])
    case loading
    case error(ErrorViewModel)
}

struct ParticipantsViewModel {
    let nickname: String
    let carLabel: String
    let imageUrl: String?
    let userInfo: String
}
