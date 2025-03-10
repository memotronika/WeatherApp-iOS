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
    
    var viewCounter = 5
    
    var internalViewPosition : CGRect!
    override func viewDidLoad() {
        super.viewDidLoad()
        numberLabel.text = String(viewCounter)
        internalViewPosition = InternalView.frame
    }

    @IBAction func PanOfInternalView(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: InternalView)
        InternalView.center.x += translation.x
        sender.setTranslation(.zero, in: InternalView)
       
        if sender.state == .ended {
            if InternalView.frame.minX < -InternalView.frame.width / 7 {
                leftlViewSwipe(object: InternalView)
            }
            else if InternalView.frame.maxX > view.frame.width + InternalView.frame.width / 7 {
                rightViewSwipe(object: InternalView)
                
            }
            else{
                UIView.animate(withDuration: 0.3) {
                               self.InternalView.frame = self.internalViewPosition
                           }
            }
//
        
        }
    }
    
    func leftlViewSwipe(object: UIView) {
        UIView.animate(withDuration: 0.4, animations: {
            object.frame = CGRect(x: -object.frame.width, y: object.frame.minY, width: object.frame.width, height: object.frame.height)
        }) { _ in
            object.frame = CGRect(x: self.view.frame.width + object.frame.width, y: object.frame.minY, width: object.frame.width, height: object.frame.height)
            
            self.viewCounter += 1
            self.numberLabel.text = String(self.viewCounter)
            
            UIView.animate(withDuration: 0.4) {
                object.frame = self.internalViewPosition
            }
        }
    }
    
    func rightViewSwipe(object: UIView) {
        UIView.animate(withDuration: 0.4, animations: {
            object.frame = CGRect(x: self.view.frame.width + object.frame.width, y: object.frame.minY, width: object.frame.width, height: object.frame.height)        }) { _ in
            object.frame = CGRect(x: -object.frame.width, y: object.frame.minY, width: object.frame.width, height: object.frame.height)
            
            self.viewCounter -= 1
            self.numberLabel.text = String(self.viewCounter)
            
            UIView.animate(withDuration: 0.4) {
                object.frame = self.internalViewPosition
            }
        }
    }
}

