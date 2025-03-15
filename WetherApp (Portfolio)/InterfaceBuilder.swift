//
//  InterfaceBuilder.swift
//  WetherApp (Portfolio)
//
//  Created by Anton Angel on 12/03/2025.
//

import UIKit
class InterfaceBuilder {
    
    let constants : Constants!
    let viewController : ViewController!
    let innerViewsQuantity : Int!
    var innerViewsOnLeft : [UIView] = []
    var innerViewsOnRight : [UIView] = []
    var mainInnerViewPosition : CGRect!

    init(constants: Constants, view: ViewController, innerViewsQuantity: Int) {
        self.viewController = view
        self.constants = constants
        self.innerViewsQuantity = innerViewsQuantity
        
    }
    public func setupInterface() {
        setupMainInnerView()
        setupOtherInnerViews()
        setupStaticObjects()
    }
    
    private func setupMainInnerView() {
        let innerView = InnerView(viewNumber: 0)
        viewController.view.addSubview(innerView)
        innerView.frame = CGRect(x: constants.sideGap, y: constants.topGap, width: viewController.view.frame.width - (constants.sideGap * 2), height: viewController.view.frame.height - constants.topGap - constants.bottomGap)
        mainInnerViewPosition = innerView.frame
        appendViewDesign(view: innerView)
        viewController.mainInnerView = innerView
        viewController.internalViews.append(innerView)
    }
    
    func setupOtherInnerViews() {
        for viewNr in 0..<innerViewsQuantity {
            setupOneOtherInnerView(viewNr: viewNr)
        }
    }
    
    func setupStaticObjects(){
    }

    func setupOneOtherInnerView(viewNr : Int) {
        let newView = InnerView(viewNumber: viewNr + 1)
        newView.backgroundColor = .red
        viewController.view.addSubview(newView)
        newView.frame = CGRect(x: Int(constants.view.frame.width) * (viewNr + 1), y: Int(constants.topGap), width: Int(constants.view.frame.width - constants.sideGap * 2), height: Int(constants.view.frame.height - constants.topGap - constants.bottomGap))
        appendViewDesign(view: newView)
        viewController.internalViews.append(newView)
        innerViewsOnRight.append(newView)
        
    }
    
    
    func appendViewDesign(view : InnerView) {
        view.layer.cornerRadius = constants.cornerRadius
        view.clipsToBounds = true
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        view.backgroundColor = UIColor.clear
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1


        blurEffectView.contentView.addSubview(view.weatherImageView)
        blurEffectView.contentView.addSubview(view.cityLabel)
        
        view.weatherImageView.image = UIImage(systemName: "star.fill")
        
        view.weatherImageView.contentMode = .scaleAspectFit

        view.cityLabel.text = String(view.viewNumber)
        view.cityLabel.textColor = .black
        view.cityLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        view.cityLabel.textAlignment = .center
        view.cityLabel.numberOfLines = 0
        
        view.weatherImageView.frame = CGRect(x: 0,
                                             y: 0,
                                             width: 50,
                                             height: 50)

        
        
        let labelWidth = blurEffectView.bounds.width - 20
        view.cityLabel.frame = CGRect(x: 10,
                                      y: view.weatherImageView.frame.maxY + 10,
                                      width: labelWidth,
                                      height: 50)
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
    
    func swipeLeft() {
        
        self.innerViewsOnLeft.append(self.viewController.mainInnerView)
            
        self.viewController.mainInnerView = (self.innerViewsOnRight.removeFirst() as! InnerView)
    }
    
    
    func swipeRight() {
        
        self.innerViewsOnRight.insert(self.viewController.mainInnerView, at: 0)
            
        self.viewController.mainInnerView = (self.innerViewsOnLeft.removeLast() as! InnerView)
    }
    
    func setupPosition() {
        UIView.animate(withDuration: 0.4) {
            for viewNr in 0..<self.innerViewsOnLeft.count{
                self.innerViewsOnLeft[viewNr].frame.origin.x = -self.mainInnerViewPosition.width * CGFloat(self.innerViewsOnLeft.count - viewNr)
            }
            
            self.viewController.mainInnerView.frame = self.mainInnerViewPosition
            for viewNr in 0..<self.innerViewsOnRight.count{
                self.innerViewsOnRight[viewNr].frame.origin.x = self.viewController.view.frame.width + self.mainInnerViewPosition.width * CGFloat(viewNr)
            }
            self.viewController.mainInnerView.isUserInteractionEnabled = true
            self.viewController.mainInnerView.addGestureRecognizer(self.viewController.panGesture)
        }
    }
}
