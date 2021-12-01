//
//  ViewController.swift
//  PercentageCircle
//
//  Created by Duong Bao Long on 11/28/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewCircle: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let circle = CircleDrag()
        circle.frame = CGRect(x: viewCircle.bounds.width/2 - 200 , y: viewCircle.bounds.height/2 - 200, width: 400, height: 400)

        viewCircle.addSubview(circle)
    }
}

