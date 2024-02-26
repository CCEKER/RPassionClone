//
//  Participants.swift
//  TourApp
//
//  Created by Cagatay Ceker on 20.02.2024.
//

import Foundation

struct TourParticipants: Decodable {
    let participants: [Participant]
    let totalCount: Int
}

struct Participant: Decodable {
    let id: String
    let driver: Driver
    let car: Car
	let passengers: [Passenger]
}

struct Driver: Decodable {
    let id: String
    let userInfo: String
}

struct Passenger: Decodable {
    let id: String
    let userInfo: String
}

