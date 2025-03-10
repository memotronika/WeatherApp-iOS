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
    var leftViewPosition : CGRect!
    var rightViewPosition : CGRect!
    var leftView : UIView!
    var rightView : UIView!
    var middleView : UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberLabel.text = String(viewCounter)
        
        
        internalViews = ["left":firstInternalView,"middle":secondInternalView,"right":thirdInternalView]
        middleViewPosition = secondInternalView.frame
        for view in internalViews{
            setViewPosition(view: view.value, side: view.key)
        }
        leftViewPosition = firstInternalView.frame
        rightViewPosition = thirdInternalView.frame
        leftView = firstInternalView
        rightView = thirdInternalView
        middleView = secondInternalView
    }

    
    
    
    
    
    @IBAction func PanOfInternalView(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: middleView)
        firstInternalView.center.x += translation.x
        secondInternalView.center.x += translation.x
        thirdInternalView.center.x += translation.x
        
        sender.setTranslation(.zero, in: secondInternalView)
        
        if sender.state == .ended {
            if middleView.frame.minX < -secondInternalView.frame.width / 7 {
                leftlViewSwipe(left: leftView, right: rightView, middle: middleView)
            }
            else if middleView.frame.maxX > view.frame.width + middleView.frame.width / 7 {
                rightViewSwipe(left: leftView, right: rightView, middle: middleView)
                
            }
            else{
                UIView.animate(withDuration: 0.3) {
                    self.middleView.frame = self.middleViewPosition
                    self.rightView.frame = self.rightViewPosition
                    self.leftView.frame = self.leftViewPosition
                    
                }
            }
        }
    }
    
    func leftlViewSwipe(left : UIView, right : UIView, middle : UIView) {
        var placeholderView : UIView!
        UIView.animate(withDuration: 0.4, animations: {
            right.frame = self.middleViewPosition
            middle.frame = CGRect(x: -middle.frame.width, y: middle.frame.minY, width: middle.frame.width, height: middle.frame.height)
            
        }) { _ in
            left.frame = CGRect(x: self.view.frame.width + left.frame.width, y: left.frame.minY, width: left.frame.width, height: left.frame.height)
            
        }
        placeholderView = left
        leftView = middle
        middleView = right
        rightView = placeholderView
        
    }
    
    func rightViewSwipe(left: UIView, right: UIView, middle: UIView) {
        var placeholderView: UIView!
        
        UIView.animate(withDuration: 0.4, animations: {
            left.frame = self.middleViewPosition
            middle.frame = CGRect(x: self.view.frame.width + middle.frame.width, y: middle.frame.minY, width: middle.frame.width, height: middle.frame.height)
            
        }) { _ in
            right.frame = CGRect(x: -right.frame.width, y: right.frame.minY, width: right.frame.width, height: right.frame.height)
            
            // Меняем ссылки на вьюхи
            placeholderView = right
            self.rightView = middle
            self.middleView = left
            self.leftView = placeholderView
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
