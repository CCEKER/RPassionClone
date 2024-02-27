//
//  ErrorViewModel.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.02.2024.
//

import Foundation

struct ErrorViewModel {
    let title: String
    let description: String?
    let actionButtonTitle: String?
    let cancelButtonTitle: String
}

struct ErrorResponse: Codable {
    let errors: [ErrorDetail]
}

struct ErrorDetail: Codable {
    let code: String
    let message: String
}
