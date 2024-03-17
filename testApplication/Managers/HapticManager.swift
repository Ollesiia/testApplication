//
//  HapticManager.swift
//  testApplication
//
//  Created by Olesia Skydan on 17.03.2024.
//

import UIKit

final class HapticManager {
    static let shared = HapticManager()
    
    private init() {}
    
    public func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
            let notifiactionGeneration = UINotificationFeedbackGenerator()
            notifiactionGeneration.prepare()
            notifiactionGeneration.notificationOccurred(type)
    }
}

