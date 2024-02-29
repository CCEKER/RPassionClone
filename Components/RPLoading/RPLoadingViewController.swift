//
//  RPLoadingViewController.swift
//  TourApp
//
//  Created by Serdar Y on 29/02/2024.
//

import UIKit

class RPLoadingViewController: UIViewController {

	private let loadingView = RPLoadingView()
	private(set) var viewModel: RPLoadingViewModel!
	
	init(viewModel: RPLoadingViewModel) {
		super.init(nibName: nil, bundle: nil)
		self.viewModel = viewModel
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		self.view = loadingView
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		loadingView.viewModel = viewModel
    }
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		.lightContent
	}
}
