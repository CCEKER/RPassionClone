//
//  TourDetailModel.swift
//  TourApp
//
//  Created by Cagatay Ceker on 8.02.2024.
//

import Foundation

struct TourDetailModel: Codable {
    let owner: Owner
    let id: String
    let title: String
    let description: String
    let startDate: String
    let endDate: String
    let lastRegistrationDate: String
    let participantsLimit: Int
    let allowedMakers: [AllowedMaker]
    let participantsJoined: Int
    let minHPLimit: Int?
    let tourType, status: String
    let images: [String]
    let startTime: String
    let locationsCount: Int
    let tripsCount: Int
    let itineraryEventsCount: Int

    enum CodingKeys: String, CodingKey {
        case owner
        case id
        case title
        case description
        case startDate
        case endDate
        case lastRegistrationDate
        case participantsLimit
        case allowedMakers
        case participantsJoined
        case minHPLimit
        case tourType
        case status
        case images
        case startTime
        case locationsCount
        case tripsCount
        case itineraryEventsCount
    }
}

struct AllowedMaker: Codable {
    let id, title: String
    let image: String
    let key: String
}

struct Owner: Codable {
    let id: String
    let profileImageUrl: String
    let userInfo: String

    enum CodingKeys: String, CodingKey {
        case id
        case profileImageUrl
        case userInfo
    }
}
