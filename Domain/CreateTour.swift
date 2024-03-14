//
//  CreateTour.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.03.2024.
//

import Foundation

struct CreateTourResponse: Codable {
    let id: String
    let title: String
    let description: String?
    let tourType: TourType
    let allowedMakers: [AllowedMaker]
    let minHpLimit: Int
    let images: [String]?
}

enum TourType: String, Codable {
    case `public` = "PUBLIC"
    case `private` = "PRIVATE"
    case invitationOnly = "INVITATON_ONLY"
    
    var intValue: Int {
        switch self {
        case .public:
            return 0
        case .private:
            return 1
        case .invitationOnly:
            return 2
        }
    }
}

struct CreateTourDayModel: Codable {
    let id: String
    let day: Int
    let descriptions: [String]
}

struct ItineraryTourModel: Codable {
    let locations: [String]
    let trips: [String]
    let journeys: [Journey]
}

struct Journey: Codable {
    let id: String
    let day: Int
    let itinerary: [String]
    let descriptions: [String]
}
