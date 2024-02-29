//
//  RPLoadingView.swift
//  TourApp
//
//  Created by Serdar Y on 29/02/2024.
//

import UIKit

public struct RPLoadingViewModel {
	public let caption: String?
	
	public init(caption: String? = nil) {
		self.caption = caption
	}
}

final class RPLoadingView: UIView {
	
	private let captionDelayInSeconds: Double = 4.0
	private let loadingAnimationSize: CGFloat = 50.0
	private let loadingAnimationOffset: CGFloat = 52.0
	private var loadingAnimationCenterYConstraint: NSLayoutConstraint?
	
	private let loadingAnimation: UIActivityIndicatorView = {
		let view = UIActivityIndicatorView(style: .large)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.color = .white
		return view
	}()
	
	private let captionLabel: UILabel = {
		let view = UILabel()
		view.text = "Loading..."
		return view
	}()
	
	var viewModel: RPLoadingViewModel? {
		didSet {
			adaptStyle()
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(code:) has not been implemented")
	}
	
	private func setup() {
		setupBackgroundView()
		setupLoadingAnimation()
		setupCaptionLabel()
		setupConstraints()
		adaptStyle()
	}
	
	private func setupBackgroundView() {
		backgroundColor = UIColor.black.withAlphaComponent(0.5)
	}
	
	private func setupLoadingAnimation() {
		loadingAnimation.startAnimating()
		addSubview(loadingAnimation)
	}
	
	private func setupCaptionLabel() {
		captionLabel.translatesAutoresizingMaskIntoConstraints = false
		captionLabel.textAlignment = .center
		captionLabel.numberOfLines = 0
		captionLabel.textColor = .white
		addSubview(captionLabel)
	}
	
	private func setupConstraints() {
		let centerYConstraint = loadingAnimation.centerYAnchor.constraint(equalTo: centerYAnchor)
		NSLayoutConstraint.activate([
			centerYConstraint,
			loadingAnimation.centerXAnchor.constraint(equalTo: centerXAnchor),
			loadingAnimation.widthAnchor.constraint(equalToConstant: loadingAnimationSize),
			loadingAnimation.heightAnchor.constraint(equalToConstant: loadingAnimationSize),
			
			captionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
			captionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
			captionLabel.topAnchor.constraint(equalTo: loadingAnimation.bottomAnchor, constant: 12)
		])
		
		loadingAnimationCenterYConstraint = centerYConstraint
	}
	
	private func configureDelayedCaption(withText text: String) {
		loadingAnimationCenterYConstraint?.constant = -loadingAnimationOffset
		captionLabel.text = text
		
		DispatchQueue.main.asyncAfter(deadline: .now() + captionDelayInSeconds) { [weak self] in
			self?.captionLabel.isHidden = false
		}
	}
	
	private func adaptStyle() {
		guard let viewModel = viewModel else {
			return
		}

		captionLabel.isHidden = true
		loadingAnimationCenterYConstraint?.constant = 0.0
		if let caption = viewModel.caption {
			configureDelayedCaption(withText: caption)
		}
		captionLabel.textColor = .white
	}
}
