//
//  Constants.swift
//  testApplication
//
//  Created by Olesia Skydan on 17.03.2024.
//

import Foundation
import UIKit

struct Constants {
    struct Circle {
        static let initialSize = CGSize(width: 200, height: 200)
        static let maxSize = CGSize(width: 400, height: 400)
        static let minSize = CGSize(width: 20, height: 20)
        static let backgroundColor: UIColor = .blue
        static let cornerRadius: CGFloat = 100
        static let durationForAnimation = 0.5
        static let resizing: CGFloat = 20
    }
    
    struct Radius {
        static let width: CGFloat = 2
    }
    
    struct Button {
        static let height: Int = 60
        static let width: Int = 60
        static let bottomAnchor: CGFloat = -20
    }
    
    struct Line {
        static let initialX: CGFloat = 100
        static let height: CGFloat = 2
        static let width: CGFloat = 100
        static let animationDuration: TimeInterval = 2
        static let animationDelay: TimeInterval = TimeInterval.random(in: 2..<4)
    }
}
