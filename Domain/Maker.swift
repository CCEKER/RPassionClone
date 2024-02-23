//
//  Maker.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import Foundation

struct Maker: Codable {
    let id: String
    let title: String
    let image: String?
    let key: String
}

struct MakerModel: Codable {
    let id: String
    let title: String
    let key: String
}

struct MakerModelTrim: Codable {
    let id: String
    let title: String
    let parent: String
}
