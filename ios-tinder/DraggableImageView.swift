//
//  DraggableImageView.swift
//  ios-tinder
//
//  Created by Savio Tsui on 11/10/16.
//  Copyright © 2016 Savio Tsui. All rights reserved.
//

import UIKit

class DraggableImageView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    fileprivate var initialProfileImageCenterPoint = CGPoint()
    fileprivate var rotationDirection: CGFloat = 1

    var image: UIImage? {
        get { return profileImageView.image }
        set { profileImageView.image = newValue }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }

    func initSubviews() {
        // standard initialization logic
        let nib = UINib(nibName: "DraggableImageView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        profileImageView.isUserInteractionEnabled = true
        addSubview(contentView)
    }

    @IBAction func onPan(_ sender: UIPanGestureRecognizer) {
        // let velocity = sender.velocity(in: parentView)

        let translation = sender.translation(in: contentView)
        let location = sender.location(in: contentView)

        print("translation: \(translation) location: \(location)")

        if sender.state == UIGestureRecognizerState.began {
            // print("Gesture began at: \(point)")
            initialProfileImageCenterPoint = profileImageView.center
            rotationDirection = location.y >= profileImageView.frame.height / 2 ? -1 : 1
        }
        else if sender.state == UIGestureRecognizerState.changed {
            // print("Gesture changed at: \(point); velocity: \(velocity.y)")
            profileImageView.center = CGPoint(x: initialProfileImageCenterPoint.x + translation.x, y: initialProfileImageCenterPoint.y)
            let currentRotationAngle = self.rotationDirection * translation.x / 2
            UIView.animate(withDuration: 0.3, animations: {
                self.profileImageView.transform = CGAffineTransform(rotationAngle: CGFloat(currentRotationAngle).degreesToRadians)
            })
        }
        else if sender.state == UIGestureRecognizerState.ended {
            if (translation.x > 100) {
                UIView.animate(withDuration: 1.0, animations: {
                    self.profileImageView.center = CGPoint(x: self.initialProfileImageCenterPoint.x + (self.window?.frame.width)! * 2, y: self.initialProfileImageCenterPoint.y)
                })
            }
            else if (translation.x < -100) {
                UIView.animate(withDuration: 1.0, animations: {
                    self.profileImageView.center = CGPoint(x: self.initialProfileImageCenterPoint.x - (self.window?.frame.width)! * 2, y: self.initialProfileImageCenterPoint.y)
                })
            }
            else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.profileImageView.transform = CGAffineTransform.identity
                    self.profileImageView.center = CGPoint(x: self.initialProfileImageCenterPoint.x, y: self.initialProfileImageCenterPoint.y)
                })
            }
        }
    }
}

// http://stackoverflow.com/questions/29179692/how-can-i-convert-from-degrees-to-radians/29179878#29179878
extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
    var radiansToDegrees: Double { return Double(self) * 180 / .pi }
}
extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}
