//
//  InterfaceBuilder.swift
//  WetherApp (Portfolio)
//
//  Created by Anton Angel on 12/03/2025.
//

import UIKit
class InterfaceBuilder {
    
    let constants : Constants!
    let view : UIView!
    init(constants: Constants, view: UIView, innerViewsQuantity: Int) {
        self.view = view
        self.constants = constants
        
    }
    public func setupInterface() {
        setupMainInnerView()
        setupOtherInnerViews()
        setupStaticObjects()
        
        
        
    }
    
    private func setupMainInnerView() {
        let innerView = UIView()
        innerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(innerView)
        
        NSLayoutConstraint.activate([
            innerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constants.sideGap),
            innerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constants.sideGap),
            innerView.topAnchor.constraint(equalTo: view.topAnchor, constant: constants.topGap),
            innerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constants.bottomGap)
        ])
        innerView.layer.cornerRadius = constants.cornerRadius
        innerView.clipsToBounds = true
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = innerView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        innerView.addSubview(blurEffectView)
        innerView.backgroundColor = UIColor.clear
        innerView.layer.borderColor = UIColor.black.cgColor
        innerView.layer.borderWidth = 1
        
        
        
        
        
        
        
        
//adding first image
        let imageView1 = UIImageView(image: .grad)
        imageView1.contentMode = .scaleAspectFit
        imageView1.translatesAutoresizingMaskIntoConstraints = false

// Adding text
        let label = UILabel()
        label.text = "Hello"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

       

//         Adding objects on top of blur
        blurEffectView.contentView.addSubview(imageView1)
        blurEffectView.contentView.addSubview(label)

        // Auto Layout
        NSLayoutConstraint.activate([
            imageView1.topAnchor.constraint(equalTo: blurEffectView.contentView.topAnchor, constant: 10),
            imageView1.centerXAnchor.constraint(equalTo: blurEffectView.contentView.centerXAnchor),
            imageView1.heightAnchor.constraint(equalToConstant: 50),
            imageView1.widthAnchor.constraint(equalToConstant: 50),

            label.topAnchor.constraint(equalTo: imageView1.bottomAnchor, constant: 10),
            label.centerXAnchor.constraint(equalTo: blurEffectView.contentView.centerXAnchor),
            label.leadingAnchor.constraint(equalTo: blurEffectView.contentView.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: blurEffectView.contentView.trailingAnchor, constant: -10),

            
        ])
    }
    func setupOtherInnerViews() {
        
    }
    func setupStaticObjects(){
    }

    
    
    func innerViewBuild() {
        return
    }
    func innerViewToMax(){
        return
    }
    func innerViewToMin(){
        return
    }
    func innerViewToCenter(){
        return
    }
    
    
}
