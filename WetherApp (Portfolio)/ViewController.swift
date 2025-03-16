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
    var heartImageView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cities = ["London", "New York", "Paris", "Rome", "Moscow"]
        ifCities()
        
        
        constants = Constants(view: self.view)
        interfaceBuilder = InterfaceBuilder(constants: self.constants, view: self, innerViewsQuantity: cities.count, cities: cities)
        interfaceBuilder.setupInterface()
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        mainInnerView.addGestureRecognizer(panGesture)

        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.heartImageView.frame = CGRect(x: self.view.safeAreaInsets.top,
                                              y: self.view.safeAreaInsets.top,
                                              width: self.view.frame.height / 27 * 2,
                                              height: self.view.frame.height / 27 * 2)
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
    
    
    
    func ifCities() {
        let defaults = UserDefaults.standard

        if let cities = defaults.array(forKey: "сities") as? [String] {
            print("Массив Cities найден: \(cities)")
        } else {
            print("Массив Cities отсутствует в UserDefaults, создаем новый.")
            defaults.set([], forKey: "сities")
            defaults.synchronize()
        }
    }
  
}



