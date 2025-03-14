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
    init(constants: Constants, view: UIView) {
        self.view = view
        self.constants = constants
        
    }
    
    public func setupInnerView() {
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
    func staticObjectsBuild(){
        return
    }
    
}
