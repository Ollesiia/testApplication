//
//  CustomButton.swift
//  testApplication
//
//  Created by Olesia Skydan on 17.03.2024.
//

import UIKit

class CustomButton: UIButton {
    enum TypeOfButton {
        case plus
        case minus
    }
    
    init(typeOfButton: TypeOfButton) {
        super.init(frame: CGRect(x: 0, y: 0, width: 60, height: 60))

        switch typeOfButton {
        case .minus:
            self.setImage(UIImage(systemName: "minus"), for: UIControl.State.normal)
        case .plus:
            self.setImage(UIImage(systemName: "plus"), for: UIControl.State.normal)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

