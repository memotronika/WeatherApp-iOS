//
//  InterfaceBuilder.swift
//  WetherApp (Portfolio)
//
//  Created by Anton Angel on 12/03/2025.
//

import UIKit
class InterfaceBuilder {
    public func setupInnerView(view: UIView, insert : UIEdgeInsets = .zero) {
        let innerView = UIView()
        innerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(innerView)
        
        NSLayoutConstraint.activate([
            innerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insert.left),
            innerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -insert.right),
            innerView.topAnchor.constraint(equalTo: view.topAnchor, constant: insert.top),
            innerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insert.bottom)
        ])
        innerView.layer.cornerRadius = Constants.cornerRadius
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
}
