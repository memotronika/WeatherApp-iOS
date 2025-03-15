//
//  ViewController.swift
//  WetherApp (Portfolio)
//
//  Created by Anton Angel on 09/03/2025.
//

import UIKit

class ViewController: UIViewController {
    var constants : Constants!
    var interfaceBuilder : InterfaceBuilder!
    var numberLabel = UILabel()
    var cities : [String]!
    var mainInnerView : InnerView!
    var panGesture : UIPanGestureRecognizer!
    var apiObject : APIRequest!
    var internalViews : [InnerView]! = []
    var mainViewNumber : Int! = 0
    var container : UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cities = ["London", "New York", "Paris", "Rome", "Moscow"]
        
        
        constants = Constants(view: self.view)
        interfaceBuilder = InterfaceBuilder(constants: self.constants, view: self, innerViewsQuantity: cities.count, cities: cities)
        interfaceBuilder.setupInterface()
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        mainInnerView.addGestureRecognizer(panGesture)

        
        
    }
    
    
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: mainInnerView)
        for view in internalViews {
            view.center.x += translation.x
        }
        sender.setTranslation(.zero, in: mainInnerView)
        
        if sender.state == .ended {
            if mainInnerView.frame.minX < -mainInnerView.frame.width / 4 && !interfaceBuilder.innerViewsOnRight.isEmpty{
                interfaceBuilder.swipeLeft()
            }else if mainInnerView.frame.maxX > view.frame.width + mainInnerView.frame.width / 4 && !interfaceBuilder.innerViewsOnLeft.isEmpty{
                interfaceBuilder.swipeRight()
            }
            interfaceBuilder.setupPosition()
        }
        
    }
  
}



