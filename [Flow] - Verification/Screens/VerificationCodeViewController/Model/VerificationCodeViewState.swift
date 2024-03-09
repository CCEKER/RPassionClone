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
	let isTimerLabelHidden: Bool
	let isResendCodeButtonHidden: Bool
	let shouldTimerStart: Bool
	let userEmail: String
}
