//
//  CreateTour.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.03.2024.
//

import Foundation

struct CreateTourResponse: Decodable {
    let id: String
    let title: String
    let description: String?
    let tourType: TourType
    let allowedMakers: [AllowedMaker]
    let minHpLimit: Int
    let images: [String]?
}

enum TourType: Int, Decodable {
    case `public` = 0
    case `private` = 1
    case invitationOnly = 2
    
    var stringValue: String {
        switch self {
        case .public:
            return "PUBLIC"
        case .private:
            return "PRIVATE"
        case .invitationOnly:
            return "INVITATION_ONLY"
        }
    }
}
