//
//  Constants.swift
//  WetherApp (Portfolio)
//
//  Created by Anton Angel on 12/03/2025.
//
import UIKit

struct Constants {
    let view : UIView
    let sideGap : CGFloat
    let topGap : CGFloat
    let bottomGap : CGFloat
    let cornerRadius : CGFloat
    let motherViewFrame : CGRect
    let motherViewHeight : CGFloat
    let motherViewWidth : CGFloat

    let insertSpace : UIEdgeInsets
    init(view : UIView) {
        self.view = view
        self.sideGap = view.frame.width / 11
        self.topGap = view .frame.height / 7
        self.bottomGap = view.frame.height / 13
        self.cornerRadius = view.frame.width / 20
        self.insertSpace = .init(top: topGap, left: sideGap, bottom: bottomGap, right: sideGap)
        self.motherViewFrame = view.frame
        self.motherViewHeight = view.frame.height
        self.motherViewWidth = view.frame.width
    }
    
    
    
//    let insertSpace : UIEdgeInsets = .init(top: 120, left: 40, bottom: 50, right: 40)
}
