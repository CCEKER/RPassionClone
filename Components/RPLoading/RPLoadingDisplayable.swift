//
//  RPLoadingDisplayable.swift
//  TourApp
//
//  Created by Serdar Y on 29/02/2024.
//

import Foundation
import UIKit

protocol RPLoadingDisplayable {
	func showLoading(viewModel: RPLoadingViewModel)
	func hideLoading()
}

extension RPLoadingDisplayable where Self: UIViewController {
	func showLoading(viewModel: RPLoadingViewModel) {
		let viewController = RPLoadingViewController(viewModel: viewModel)
		viewController.view.translatesAutoresizingMaskIntoConstraints = false
		self.addChild(viewController)
		self.view.addSubview(viewController.view)
		
		NSLayoutConstraint.activate([
			viewController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			viewController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
			viewController.view.topAnchor.constraint(equalTo: self.view.topAnchor),
			viewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
		])
		
		viewController.didMove(toParent: self)
	}
	
	func hideLoading() {
		guard let viewController = self.children.first(where: {$0.isKind(of: RPLoadingViewController.self)}) else {
			return
		}
		
		viewController.willMove(toParent: nil)
		viewController.view.removeFromSuperview()
		viewController.removeFromParent()
	}
}
