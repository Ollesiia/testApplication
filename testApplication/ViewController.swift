//
//  ViewController.swift
//  testApplication
//
//  Created by Olesia Skydan on 17.03.2024.
//

import UIKit

class ViewController: UIViewController {
    private let circleView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.Circle.initialSize.width, height: Constants.Circle.initialSize.height))
    private let radiusView = UIView()
    private let horizontalLineAbove = UIView()
    private let horizontalLineBelow = UIView()
    private let circleAnimator = CircleAnimator()
    private lazy var alertManager = AlertManager()
    
    private let insertSizeButton = CustomButton(typeOfButton: .plus)
    private let reduceSizeButton = CustomButton(typeOfButton: .minus)
    
    private lazy var collisionDetector: CollisionDetector = {
        let detector = CollisionDetector(with: circleView)
        detector.onCollisionDetected = { [weak self] hasCollision in
            if !hasCollision {
                self?.showCollisionAlert()
            }
        }
        return detector
    }()
    
    private lazy var lineAnimation: LineAnimation = {
          return LineAnimation(lineConfigurations: [
            (horizontalLineAbove, view.bounds.midY + 20, view.bounds.maxY - 100),
            (horizontalLineBelow, 100, view.bounds.midY - 20)
          ])
      }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonHandling()
        setupCircleAndButtons()
        lineAnimation.startAnimation()
        setupHorizontalLines()
        
        lineAnimation.animationListener = collisionDetector
    }
}

extension ViewController {
    private func setupCircleAndButtons() {
        self.view.backgroundColor = .white
        circleView.center = self.view.center
        circleView.backgroundColor = Constants.Circle.backgroundColor
        circleView.layer.cornerRadius = Constants.Circle.initialSize.width / 2
        circleAnimator.addRotationAnimation(to: circleView)
        
        insertSizeButton.tintColor = .red
        reduceSizeButton.tintColor = .red
        
        radiusView.backgroundColor = .yellow
        let radiusWidth = Constants.Radius.width
        let radiusHeight = Constants.Circle.initialSize.width / 2
        radiusView.frame = CGRect(x: Constants.Circle.initialSize.width / 2 - radiusWidth / 2, y: 0, width: radiusWidth, height: radiusHeight)
        circleView.addSubview(radiusView)
        
        self.view.addSubview(circleView)
        self.view.addSubview(insertSizeButton)
        self.view.addSubview(reduceSizeButton)
        
        insertSizeButton.translatesAutoresizingMaskIntoConstraints = false
        reduceSizeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            reduceSizeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constants.Button.bottomAnchor),
            reduceSizeButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: -50 - 100/2),
            insertSizeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constants.Button.bottomAnchor),
            insertSizeButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: 50 + 100/2),
        ])
    }
    
    private func setupHorizontalLines() {
        let initialXPosition = view.bounds.width + Constants.Line.width
        let yPositionAbove: CGFloat = view.bounds.midY - 50
        let yPositionBelow: CGFloat = view.bounds.midY + 50

        horizontalLineAbove.backgroundColor = .black
        horizontalLineAbove.frame = CGRect(x: initialXPosition, y: yPositionAbove, width: Constants.Line.width, height: Constants.Line.height)
        view.addSubview(horizontalLineAbove)

        horizontalLineBelow.backgroundColor = .black
        horizontalLineBelow.frame = CGRect(x: initialXPosition, y: yPositionBelow, width: Constants.Line.width, height: Constants.Line.height)
        view.addSubview(horizontalLineBelow)
    }

}

extension ViewController {
    private func buttonHandling() {
        insertSizeButton.addTarget(self, action: #selector(buttonActionAddSize), for: .touchUpInside)
        reduceSizeButton.addTarget(self, action: #selector(buttonActionDownsize), for: .touchUpInside)
    }
    
    private func showCollisionAlert() {
        self.alertManager.showInvalidEmailAlert(on: self)
        lineAnimation.stopAnimation()
    }
    
    private func updateRadiusView() {
        radiusView.frame = CGRect(x: circleView.bounds.width / 2 - Constants.Radius.width / 2, y: 0, width: Constants.Radius.width, height: circleView.frame.width / 2)
    }
    
    @objc func buttonActionAddSize(sender: UIButton!) {
        let newSize = CGSize(width: circleView.frame.size.width + Constants.Circle.resizing, height: circleView.frame.size.height + Constants.Circle.resizing)
        let adjustedSize = CGSize(width: min(newSize.width, Constants.Circle.maxSize.width), height: min(newSize.height, Constants.Circle.maxSize.height))

        UIView.animate(withDuration: Constants.Circle.durationForAnimation) {
            self.circleView.frame = CGRect(x: 0, y: 0, width: adjustedSize.width, height: adjustedSize.height)
            self.circleView.center = self.view.center
            self.circleView.layer.cornerRadius = adjustedSize.width / 2
            
            self.updateRadiusView()
        }
    }

    @objc func buttonActionDownsize(sender: UIButton!) {
        let newSize = CGSize(width: circleView.frame.size.width - Constants.Circle.resizing, height: circleView.frame.size.height - Constants.Circle.resizing)
        let adjustedSize = CGSize(width: max(newSize.width, Constants.Circle.minSize.width), height: max(newSize.height, Constants.Circle.minSize.height))

        UIView.animate(withDuration: Constants.Circle.durationForAnimation) {
            self.circleView.frame = CGRect(x: 0, y: 0, width: adjustedSize.width, height: adjustedSize.height)
            self.circleView.center = self.view.center
            self.circleView.layer.cornerRadius = adjustedSize.width / 2
            
            self.updateRadiusView()
        }
    }
}



