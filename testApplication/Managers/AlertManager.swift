//
//  AlertManager.swift
//  testApplication
//
//  Created by Olesia Skydan on 17.03.2024.
//

import Foundation
import UIKit

class AlertManager {
    var alert: UIAlertController?
    
    private func showBasicAlert(on vc: UIViewController, with title: String, and message: String?) {
        precondition(Thread.isMainThread, "Not on main thread")
        let alert = self.alert ?? UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,
        handler: { (action:UIAlertAction!) -> Void in
            exit(0)
        }))
        self.alert = alert
        
        vc.present(alert, animated: true)
    }

    public func showInvalidEmailAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, with: "Game over", and: "Please reload the application")
    }
}

