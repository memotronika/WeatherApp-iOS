//
//  ViewController.swift
//  WetherApp (Portfolio)
//
//  Created by Anton Angel on 09/03/2025.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var InternalView: UIView!
    
    var internalViewPosition : CGRect!
    override func viewDidLoad() {
        super.viewDidLoad()
        internalViewPosition = InternalView.frame
    }

    @IBAction func PanOfInternalView(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: InternalView)
        InternalView.center.x += translation.x
        sender.setTranslation(.zero, in: InternalView)
        if InternalView.frame.minX < -InternalView.frame.width / 7 {
            InternalView.backgroundColor = .red
        }
        else if InternalView.frame.maxX > view.frame.width + InternalView.frame.width / 7 {
            InternalView.backgroundColor = .green
        }
        if sender.state == .ended {
            InternalView.frame = internalViewPosition
        }
    }
    
}

