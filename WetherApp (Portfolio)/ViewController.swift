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
    
    
    
    
    
    
    
    var internalViews : [String:UIView]!
    
    var middleViewPosition : CGRect!
    var leftViewPosition : CGRect!
    var rightViewPosition : CGRect!
    var leftView : UIView!
    var rightView : UIView!
    var middleView : UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cities = ["london", "new york", "tokyo"]
        constants = Constants(view: self.view)
        interfaceBuilder = InterfaceBuilder(constants: self.constants, view: self.view, innerViewsQuantity: cities.count)
        
//        numberLabel.text = String(viewCounter)
//        print("a")
//        print(view.frame.width)
//        print(view.frame.height)
//        let api = APIRequest()
//        api.performRequest { weather in
//            if let weather = weather {
//                print("Температура: \(weather.temperature)°C")
//            } else {
//                print("Не удалось получить данные")
//            }
//        }
//
//        internalViews = ["left": firstInternalView, "middle": secondInternalView, "right": thirdInternalView]
//        middleViewPosition = secondInternalView.frame
//        for view in internalViews {
//            setViewPosition(view: view.value, side: view.key)
//            makeBlurView(view: view.value)
//            view.value.layer.cornerRadius = 25
//            view.value.clipsToBounds = true
//        }
//        
//        leftViewPosition = firstInternalView.frame
//        rightViewPosition = thirdInternalView.frame
//        leftView = firstInternalView
//        rightView = thirdInternalView
//        middleView = secondInternalView
//
//        let customView = createBlurredCustomView(
//            frame: CGRect(x: 50, y: 100, width: 200, height: 200),
//            image1: UIImage(systemName: "star.fill"),
//            image2: UIImage(systemName: "heart.fill"),
//            text: "Пример текста"
//        )
//        view.addSubview(customView)
//        
//        // РЕФАКТОРИ ЭТО!!!
//        numberLabel.translatesAutoresizingMaskIntoConstraints = false // Для работы с Auto Layout
//
//                numberLabel.text = "Hello, World!"
//                numberLabel.font = UIFont.systemFont(ofSize: 24)
//                numberLabel.textColor = .black
//                numberLabel.textAlignment = .center
//
//                // Добавляем в представление (view)
//        middleView.addSubview(numberLabel)
//
//                // Устанавливаем constraints для numberLabel
//                NSLayoutConstraint.activate([
//                    numberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//                    numberLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//                    numberLabel.widthAnchor.constraint(equalToConstant: 200),
//                    numberLabel.heightAnchor.constraint(equalToConstant: 50)
//                ])
//        ВОТ ДО СЮДА
        interfaceBuilder.setupInterface()

    }

    
    
    
    
    
//    @IBAction func PanOfInternalView(_ sender: UIPanGestureRecognizer) {
//        let translation = sender.translation(in: middleView)
//        firstInternalView.center.x += translation.x
//        secondInternalView.center.x += translation.x
//        thirdInternalView.center.x += translation.x
//        
//        sender.setTranslation(.zero, in: secondInternalView)
//        
//        if sender.state == .ended {
//            if middleView.frame.minX < -secondInternalView.frame.width / 7 {
//                leftlViewSwipe(left: leftView, right: rightView, middle: middleView)
//            }
//            else if middleView.frame.maxX > view.frame.width + middleView.frame.width / 7 {
//                rightViewSwipe(left: leftView, right: rightView, middle: middleView)
//                
//            }
//            else{
//                UIView.animate(withDuration: 0.3) {
//                    self.middleView.frame = self.middleViewPosition
//                    self.rightView.frame = self.rightViewPosition
//                    self.leftView.frame = self.leftViewPosition
//                    
//                }
//            }
//        }
//    }
    
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
            
            
            placeholderView = right
            self.rightView = middle
            self.middleView = left
            self.leftView = placeholderView
        }
    }
    func setViewPosition(view: UIView, side : String){
         if side == "left"{
             view.frame = CGRect(x: -middleViewPosition.width , y: middleViewPosition.minY, width: middleViewPosition.width, height: middleViewPosition.height)
        }
        if side == "right"{
            view.frame = CGRect(x: self.view.frame.width , y: middleViewPosition.minY, width: middleViewPosition.width, height: middleViewPosition.height)
        }
        if side == "middle"{
            view.frame = middleViewPosition
        }
        print(view.frame)
    }
    
    func makeBlurView(view : UIView) {
        let blurEffect = UIBlurEffect(style: .regular)
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                blurEffectView.frame = view.bounds
                blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                view.addSubview(blurEffectView)
                view.backgroundColor = UIColor.clear
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
    }
//    
}


