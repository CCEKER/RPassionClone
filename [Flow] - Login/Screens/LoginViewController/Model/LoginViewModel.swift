//
//  LoginViewModel.swift
//  TourApp
//
//  Created by Cagatay Ceker on 11.03.2024.
//

import Foundation

struct LoginViewModel {
    let navigationTitle: String
    let titleLabel: String
    let emailPlaceHolderLabel: String
    let passwordPlaceHolderLabel: String
    let hintLabel: String
    let forgotPasswordButtonTitle: String
    let buttonTitle: String
    let registerTitle: String
    let registerButtonTitle: String
}

enum LoginViewState {
    case initial(LoginViewModel)
    case loading
    case error(ErrorViewModel)
}
