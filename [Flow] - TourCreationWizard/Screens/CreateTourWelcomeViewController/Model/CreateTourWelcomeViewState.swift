//
//  CreateTourWelcomeViewState.swift
//  TourApp
//
//  Created by Cagatay Ceker on 11.03.2024.
//

import Foundation
import UIKit

enum CreateTourWelcomeViewState {
    case initial(CreateTourWelcomeViewModel)
    case loading
    case error
}

struct CreateTourWelcomeViewModel {
    let title: String
    let subtitle: String
    let image: UIImage
    let createTourButtonTitle: String
}
