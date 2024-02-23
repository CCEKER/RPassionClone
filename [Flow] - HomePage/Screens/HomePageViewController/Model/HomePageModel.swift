//
//  HomePageModel.swift
//  TourApp
//
//  Created by Cagatay Ceker on 5.01.2024.
//

import Foundation

struct HomePageModel: Codable {
    let list: [TourList]
    let totalCount: Int
}

struct TourList: Codable {
    let id: String
    let title: String
    let description: String
    let tourType: String
    let startDate: String
    let lastRegistrationDate: String
    let status: String
    let images: [String]
}

