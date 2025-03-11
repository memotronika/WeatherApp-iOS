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
        
        let api = APIRequest()
        api.performRequest { weather in
            if let weather = weather {
                print("Температура: \(weather.temperature)°C")
            } else {
                print("Не удалось получить данные")
            }
        }

        internalViews = ["left": firstInternalView, "middle": secondInternalView, "right": thirdInternalView]
        middleViewPosition = secondInternalView.frame
        for view in internalViews {
            setViewPosition(view: view.value, side: view.key)
            makeBlurView(view: view.value)
            view.value.layer.cornerRadius = 25
            view.value.clipsToBounds = true
        }
        
        leftViewPosition = firstInternalView.frame
        rightViewPosition = thirdInternalView.frame
        leftView = firstInternalView
        rightView = thirdInternalView
        middleView = secondInternalView

        let customView = createBlurredCustomView(
            frame: CGRect(x: 50, y: 100, width: 200, height: 200),
            image1: UIImage(systemName: "star.fill"),
            image2: UIImage(systemName: "heart.fill"),
            text: "Пример текста"
        )
        view.addSubview(customView)
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
//    func createCustomView(frame: CGRect, image1: UIImage?, image2: UIImage?, text: String) -> UIView {
//        
//        let containerView = UIView(frame: frame)
//        containerView.backgroundColor = UIColor.white
//        containerView.layer.cornerRadius = 15
//        containerView.layer.masksToBounds = true
//        
//        
//        // Создаем первую картинку
//        let imageView1 = UIImageView(image: image1)
//        imageView1.contentMode = .scaleAspectFit
//        imageView1.translatesAutoresizingMaskIntoConstraints = false
//        
//        // Создаем текст
//        let label = UILabel()
//        label.text = text
//        label.textColor = .black
//        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
//        label.textAlignment = .center
//        label.numberOfLines = 0
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        // Создаем вторую картинку
//        let imageView2 = UIImageView(image: image2)
//        imageView2.contentMode = .scaleAspectFit
//        imageView2.translatesAutoresizingMaskIntoConstraints = false
//
//        // Добавляем элементы в контейнер
//        containerView.addSubview(imageView1)
//        containerView.addSubview(label)
//        containerView.addSubview(imageView2)
//
//        // Настраиваем Auto Layout
//        NSLayoutConstraint.activate([
//            imageView1.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
//            imageView1.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
//            imageView1.heightAnchor.constraint(equalToConstant: 50),
//            imageView1.widthAnchor.constraint(equalToConstant: 50),
//
//            label.topAnchor.constraint(equalTo: imageView1.bottomAnchor, constant: 10),
//            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
//            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
//            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
//
//            imageView2.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
//            imageView2.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
//            imageView2.heightAnchor.constraint(equalToConstant: 50),
//            imageView2.widthAnchor.constraint(equalToConstant: 50),
//
//            imageView2.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
//        ])
//        
//        return containerView
//    }
    func createBlurredCustomView(frame: CGRect, image1: UIImage?, image2: UIImage?, text: String) -> UIView {
        let containerView = UIView(frame: frame)
        containerView.backgroundColor = UIColor.clear
        containerView.layer.cornerRadius = 15
        containerView.layer.masksToBounds = true
        containerView.layer.borderColor = UIColor.black.cgColor
        containerView.layer.borderWidth = 1

        // Создаем размытие
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = containerView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.addSubview(blurEffectView)

        // Создаем первую картинку
        let imageView1 = UIImageView(image: image1)
        imageView1.contentMode = .scaleAspectFit
        imageView1.translatesAutoresizingMaskIntoConstraints = false

        // Создаем текст
        let label = UILabel()
        label.text = text
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        // Создаем вторую картинку
        let imageView2 = UIImageView(image: image2)
        imageView2.contentMode = .scaleAspectFit
        imageView2.translatesAutoresizingMaskIntoConstraints = false

        // Добавляем элементы на размытый слой, а не напрямую в контейнер
        blurEffectView.contentView.addSubview(imageView1)
        blurEffectView.contentView.addSubview(label)
        blurEffectView.contentView.addSubview(imageView2)

        // Настраиваем Auto Layout
        NSLayoutConstraint.activate([
            imageView1.topAnchor.constraint(equalTo: blurEffectView.contentView.topAnchor, constant: 10),
            imageView1.centerXAnchor.constraint(equalTo: blurEffectView.contentView.centerXAnchor),
            imageView1.heightAnchor.constraint(equalToConstant: 50),
            imageView1.widthAnchor.constraint(equalToConstant: 50),

            label.topAnchor.constraint(equalTo: imageView1.bottomAnchor, constant: 10),
            label.centerXAnchor.constraint(equalTo: blurEffectView.contentView.centerXAnchor),
            label.leadingAnchor.constraint(equalTo: blurEffectView.contentView.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: blurEffectView.contentView.trailingAnchor, constant: -10),

            imageView2.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            imageView2.centerXAnchor.constraint(equalTo: blurEffectView.contentView.centerXAnchor),
            imageView2.heightAnchor.constraint(equalToConstant: 50),
            imageView2.widthAnchor.constraint(equalToConstant: 50),

            imageView2.bottomAnchor.constraint(equalTo: blurEffectView.contentView.bottomAnchor, constant: -10)
        ])

        return containerView
    }
}


