//
//  CircleAnimator.swift
//  testApplication
//
//  Created by Olesia Skydan on 17.03.2024.
//

import Foundation
import UIKit

class CircleAnimator {
    func addRotationAnimation(to view: UIView) {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = 2 * Double.pi
        rotationAnimation.duration = Constants.Circle.durationForAnimation
        rotationAnimation.repeatCount = .infinity
        view.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
}
