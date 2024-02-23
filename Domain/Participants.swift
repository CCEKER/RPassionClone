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

enum ParticipantsInfo {
    case none
    case single(name: String)
    case multipe(name: String, count: Int)
    
    var description: String {
        switch self {
        case .none:
            return "No participants"
        case .single(let name):
            return name
        case .multipe(let name, let count):
            return "\(name) with \(count) \(count == 1 ? "person" : "people")"
        }
    }
}
