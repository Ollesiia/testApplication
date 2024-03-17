//
//  CollisionDetector.swift
//  testApplication
//
//  Created by Olesia Skydan on 17.03.2024.
//

import Foundation
import UIKit

class CollisionDetector {
    private var collisionCount = 0
    weak var circleView: UIView?
    var onCollisionDetected: ((Bool) -> Void)?
    private var lineCollisionStates: [UIView: Bool] = [:]
    
    init(with circleView: UIView) {
        self.circleView = circleView
    }
}
extension CollisionDetector: LineAnimationListener {
    func didAnimate(lineViews: [UIView]) {
        guard let circleView = self.circleView else { return }
        
        let circleCenter = CGPoint(x: circleView.frame.midX, y: circleView.frame.midY)
        let circleRadius = circleView.frame.width / 2

        for lineView in lineViews {
            guard let lineFrame = lineView.layer.presentation()?.frame else { continue }
            
            if isIntersectingCircle(lineFrame: lineFrame, circleCenter: circleCenter, circleRadius: circleRadius) && !(lineCollisionStates[lineView] ?? true) {
                collisionCount += 1
                HapticManager.shared.vibrate(for: .error)
                lineCollisionStates[lineView] = true
                if collisionCount > 4 {
                    onCollisionDetected?(false)
                }
            } else if !isIntersectingCircle(lineFrame: lineFrame, circleCenter: circleCenter, circleRadius: circleRadius) {
                lineCollisionStates[lineView] = false
            }
        }
    }

    private func isIntersectingCircle(lineFrame: CGRect, circleCenter: CGPoint, circleRadius: CGFloat) -> Bool {
        let closestPoint = CGPoint(x: max(lineFrame.minX, min(circleCenter.x, lineFrame.maxX)),
                                   y: max(lineFrame.minY, min(circleCenter.y, lineFrame.maxY)))
        let distance = sqrt(pow(closestPoint.x - circleCenter.x, 2) + pow(closestPoint.y - circleCenter.y, 2))
        return distance <= circleRadius
    }
}

