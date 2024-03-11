//
//  VerificationCodeViewState.swift
//  TourApp
//
//  Created by Cagatay Ceker on 27.02.2024.
//

import Foundation

enum VerificationCodeViewState {
    case initial
    case error(String)
}

struct ResendVerificationCodeSuccessViewModel {
	let remainingSeconds: Int
	var isTimerLabelHidden: Bool
	var isResendCodeButtonHidden: Bool
	let shouldTimerStart: Bool
	let userEmail: String
}
