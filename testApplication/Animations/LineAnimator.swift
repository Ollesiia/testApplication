//
//  LineAnimator.swift
//  testApplication
//
//  Created by Olesia Skydan on 17.03.2024.
//

import Foundation
import UIKit

protocol LineAnimationListener: AnyObject {
    func didAnimate(lineViews: [UIView])
}

class LineAnimation {
    var shouldContinueAnimating = true
    weak var animationListener: LineAnimationListener?
    private var displayLink: CADisplayLink?
    private var lineConfigurations: [(line: UIView, minY: CGFloat, maxY: CGFloat, delay: TimeInterval)]
     
    init(lineConfigurations: [(UIView, CGFloat, CGFloat)]) {
        self.lineConfigurations = lineConfigurations.map {
            ($0.0, $0.1, $0.2, Double.random(in: 1...5))
        }
    }
    
    func startAnimation() {
        displayLink?.invalidate()
        displayLink = CADisplayLink(target: self, selector: #selector(animationStep))
        displayLink?.add(to: .main, forMode: .default)
    }
    
    @objc private func animationStep() {
        guard let linkDuration = displayLink?.duration else { return }
        
        if self.shouldContinueAnimating {
            for i in 0..<lineConfigurations.count {
                var config = lineConfigurations[i]
                guard config.delay <= 0 else {
                    config.delay -= linkDuration
                    lineConfigurations[i] = config
                    continue
                }
                config.line.frame.origin.x -= 2
                if config.line.frame.origin.x < -200 {
                    config.line.frame.origin.x = UIScreen.main.bounds.width
                    config.line.frame.origin.y = CGFloat.random(in: config.minY...config.maxY)
                    config.delay = Double.random(in: 1...5)
                }
                lineConfigurations[i] = config
            }
            animationListener?.didAnimate(lineViews: lineConfigurations.map { $0.line })
        }
    }

    func stopAnimation() {
        shouldContinueAnimating = false
        displayLink?.invalidate()
        displayLink = nil
    }
}

