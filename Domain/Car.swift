//
//  Car.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import Foundation
import UIKit

struct Car: Decodable {
    let id: String
    let nickname: String
    let label: String
    let maker: Maker
    let images: [String]
}
