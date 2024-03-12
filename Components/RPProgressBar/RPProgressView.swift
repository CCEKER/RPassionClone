//
//  RPProgressView.swift
//  TourApp
//
//  Created by Cagatay Ceker on 12.03.2024.
//

import UIKit

class RPProgressView: UIView {
    
    private var progressBars = [UIView]()
    private let totalBars = 8
    private let cornerRadius: CGFloat = 5.0
    private let separatorWidth: CGFloat = 2.0
    
    var progress: Int = 0 {
        didSet {
            updateProgress()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 5
        backgroundColor = .gray
        clipsToBounds = true
        
        setupBars()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupBars()
    }
    
    private func setupBars() {
        for i in 0..<totalBars {
            let bar = UIView()
            bar.backgroundColor = (i == 0 || i == totalBars - 1) ? .yellow : .lightGray
            if i == 0 || i == totalBars - 1 {
            }
            progressBars.append(bar)
            addSubview(bar)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let barWidth = (bounds.width - (CGFloat(totalBars - 1) * separatorWidth)) / CGFloat(totalBars)
        for (index, bar) in progressBars.enumerated() {
            let barX = CGFloat(index) * (barWidth + separatorWidth)
            bar.frame = CGRect(x: barX, y: 0, width: barWidth, height: bounds.height)
            
            if index == 0 || index == totalBars - 1 {
                bar.layer.masksToBounds = true
            }
        }
    }
    
    private func updateProgress() {
        for (index, bar) in progressBars.enumerated() {
            bar.backgroundColor = index < progress ? .progressBar : .lightGray
        }
    }
}
