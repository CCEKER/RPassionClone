//
//  GradientView.swift
//  TourApp
//
//  Created by Cagatay Ceker on 26.02.2024.
//

import UIKit

class GradientView: UIView {
    
    var startColor: UIColor = .background {
        didSet {
            updateGradient()
        }
    }
    
    var endColor: UIColor = .clear {
        didSet {
            updateGradient()
        }
    }
    
    private var gradientLayer: CAGradientLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGradientLayer()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    private func setupGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func updateGradient() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
}
