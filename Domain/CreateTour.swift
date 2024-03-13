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
