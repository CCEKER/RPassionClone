//
//  Participants.swift
//  TourApp
//
//  Created by Cagatay Ceker on 20.02.2024.
//

import Foundation

struct TourParticipants: Decodable {
    let participants: [Participant]
    let passengers: [Passenger]?
    let totalCount: Int
    let images: [String]?
}

struct Participant: Decodable {
    let id: String
    let driver: Driver
    let car: Car
}

struct Driver: Decodable {
    let id: String
    let userInfo: String
}

struct Passenger: Decodable {
    let id: String
    let userInfo: String
}

