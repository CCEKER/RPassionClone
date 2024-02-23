//
//  TourDetailsViewModel.swift
//  TourApp
//
//  Created by Cagatay Ceker on 8.02.2024.
//

import Foundation

struct TourDetailsViewModel {
    let id: String
    let title: String
    let startDate: String
    let images: [String]
    let lastRegistrationDate: String
    let allowedMakers: [AllowedMakerViewModel]
    let participantsLimit: Int
    let participantsJoined: Int
}

struct AllowedMakerViewModel {
    let id: String
    let title: String
    let image: String
}
