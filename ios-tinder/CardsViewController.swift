//
//  CardsViewController.swift
//  ios-tinder
//
//  Created by Savio Tsui on 11/10/16.
//  Copyright © 2016 Savio Tsui. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    @IBOutlet var parentView: UIView!
    @IBOutlet weak var navBarImageView: UIImageView!
    @IBOutlet weak var profileImageView: DraggableImageView!
    fileprivate var initialProfileImageCenterPoint = CGPoint()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        profileImageView.image = UIImage(named: "ryan")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
