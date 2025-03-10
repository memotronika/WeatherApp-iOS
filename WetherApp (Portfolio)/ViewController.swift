//
//  ViewController.swift
//  WetherApp (Portfolio)
//
//  Created by Anton Angel on 09/03/2025.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var firstInternalView: UIView!
    
    @IBOutlet weak var secondInternalView: UIView!
    
    @IBOutlet weak var thirdInternalView: UIView!
    
    
    
    var viewCounter = 5
    
    var internalViews : [String:UIView]!
    
    var middleViewPosition : CGRect!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberLabel.text = String(viewCounter)
        
        
        internalViews = ["left":firstInternalView,"middle":secondInternalView,"right":thirdInternalView]
        middleViewPosition = secondInternalView.frame
        print(middleViewPosition)
        for view in internalViews{
            setViewPosition(view: view.value, side: view.key)
            
        }
    }

    
    
    
    
    
    @IBAction func PanOfInternalView(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: secondInternalView)
        secondInternalView.center.x += translation.x
        sender.setTranslation(.zero, in: secondInternalView)
        
        if sender.state == .ended {
            if secondInternalView.frame.minX < -secondInternalView.frame.width / 7 {
                leftlViewSwipe(object: secondInternalView)
            }
            else if secondInternalView.frame.maxX > view.frame.width + secondInternalView.frame.width / 7 {
                rightViewSwipe(object: secondInternalView)
                
            }
            else{
                UIView.animate(withDuration: 0.3) {
                    self.secondInternalView.frame = self.middleViewPosition
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
                object.frame = self.middleViewPosition
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
                    object.frame = self.middleViewPosition
                }
            }
    }
    func setViewPosition(view: UIView, side : String){
         if side == "left"{
             view.frame = CGRect(x: -middleViewPosition.width + 5, y: middleViewPosition.minY, width: middleViewPosition.width, height: middleViewPosition.height)
        }
        if side == "right"{
            view.frame = CGRect(x: self.view.frame.width - 5 , y: middleViewPosition.minY, width: middleViewPosition.width, height: middleViewPosition.height)
        }
        if side == "middle"{
            view.frame = middleViewPosition
        }
        print(view.frame)
    }
}
