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
    var apiObject : APIRequest!
    var cities : [String]!
    
    init(constants: Constants, view: ViewController, innerViewsQuantity: Int, cities: [String]) {
        self.apiObject = APIRequest()
        self.viewController = view
        self.constants = constants
        self.innerViewsQuantity = innerViewsQuantity
        self.cities = cities
        
    }
    public func setupInterface() {
//        UserDefaults.standard.set(["London", "Paris", "New York", "Rome", "Moscow"], forKey: "cities")
        setupMainInnerView()
        setupOtherInnerViews()
        fillViews()
        setupStaticObjects()
        updateHeart()
    }
    
    func updateHeart() {
//        print(UserDefaults.standard.stringArray(forKey: "cities"))
        if (UserDefaults.standard.stringArray(forKey: "cities"))?.contains(viewController.mainInnerView.cityLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "") == true {
            viewController.heartImageView.image = UIImage(systemName: "heart.fill")
        }
        else {
            viewController.heartImageView.image = UIImage(systemName: "heart")
        }
    }
    
    func fillViews() {
        for cityNr in 0..<cities.count {
            apiObject.performRequest(city: cities[cityNr]) { weather in
                DispatchQueue.main.async {
                    if let weather = weather {
                        self.viewController.internalViews[cityNr].cityLabel.text = " \(self.cities[cityNr])"
                        self.viewController.internalViews[cityNr].temperatureLabel.text = "\(round(weather.temp))°C"
                        self.viewController.internalViews[cityNr].sunriseLabel.text = self.convertUnixTimeToReadable(weather.sunrise, weather.timezone)
                        self.viewController.internalViews[cityNr].sunsetLabel.text = self.convertUnixTimeToReadable(weather.sunset,weather.timezone)
                        self.updateHeart()
                    } else {
                        print("Не удалось получить данные")
                    }
                }
            }
        }
    }
    
    
    
    private func setupMainInnerView() {
        let innerView = InnerView(viewNumber: 0)
        viewController.view.addSubview(innerView)
        innerView.frame = CGRect(x: constants.sideGap, y: constants.topGap, width: constants.motherViewWidth-(constants.sideGap * 2), height: constants.motherViewHeight - constants.topGap - constants.bottomGap)
        mainInnerViewPosition = innerView.frame
        
        appendInnerViewDesign(view: innerView)
        innerViewBuild(view: innerView)
        
        viewController.mainInnerView = innerView
        viewController.internalViews.append(innerView)
    }
    
    
    
    func setupOtherInnerViews() {
        if innerViewsQuantity < 1 { return }
        for viewNr in 0..<innerViewsQuantity-1 {
            setupOneOtherInnerView(viewNr: viewNr)
        }
    }
    
    @objc func heartPressed() {
        let defaults = UserDefaults.standard
        let city = viewController.mainInnerView.cityLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        var cities = defaults.stringArray(forKey: "cities") ?? []
        
        if let index = cities.firstIndex(where: { $0.trimmingCharacters(in: .whitespacesAndNewlines) == city }) {
            cities.remove(at: index)
        } else {
            cities.append(city)
        }
        
        defaults.set(cities, forKey: "cities")
        updateHeart()
    }
    
    func setupStaticObjects(){
        let containerWidth : CGFloat =  25 * CGFloat(innerViewsQuantity)
        
        let heartImageView = UIImageView(image: UIImage(systemName: "heart"))
        heartImageView.tintColor = .white
        heartImageView.contentMode = .scaleAspectFit
        viewController.view.addSubview(heartImageView)
        viewController.heartImageView = heartImageView

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(heartPressed))
        heartImageView.isUserInteractionEnabled = true 
        heartImageView.addGestureRecognizer(tapGesture)
        
        
        
        

        
        
        viewController.container = UIStackView()
        viewController.container.axis = .horizontal
        viewController.container.distribution = .equalCentering
        viewController.container.alignment = .center
        viewController.container.spacing = 12
        viewController.view.addSubview(viewController.container)
        
        viewController.container.frame = CGRect(x: (constants.motherViewWidth-containerWidth)/2, y: constants.motherViewHeight*0.935, width: containerWidth, height: 12)
        
        for imageNr in 0..<self.innerViewsQuantity {
            var image : UIImageView!
            if imageNr == 0 {
                image = UIImageView(image: UIImage(systemName: "location.fill" ))
                image.tintColor = .white
            }
            else {
                image = UIImageView(image: UIImage(systemName: "circle.fill" ))
                image.tintColor = .black
            }
            image.contentMode = .scaleAspectFit
            viewController.container.addArrangedSubview(image)
        }
    }
    
    
    
    func setupOneOtherInnerView(viewNr : Int) {
        let newView = InnerView(viewNumber: viewNr + 1)
        viewController.view.addSubview(newView)
        newView.frame = CGRect(x: Int(constants.motherViewWidth) * (viewNr + 1),
                               y: Int(constants.topGap),
                               width: Int(constants.motherViewWidth - constants.sideGap * 2),
                               height: Int(constants.motherViewHeight - constants.topGap - constants.bottomGap))
        
        appendInnerViewDesign(view: newView)
        innerViewBuild(view: newView)
        viewController.internalViews.append(newView)
        innerViewsOnRight.append(newView)
        
    }
    
    
    
    private func appendInnerViewDesign(view : InnerView) {
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
        blurEffectView.contentView.addSubview(view.temperatureLabel)
        blurEffectView.contentView.addSubview(view.sunriseLabel)
        blurEffectView.contentView.addSubview(view.sunsetLabel)
        blurEffectView.contentView.addSubview(view.sunriseImageView)
        blurEffectView.contentView.addSubview(view.sunsetImageView)
        
    }
    
    
    
    
    private func innerViewBuild(view: InnerView) {
        let labelWidth = view.bounds.width - 20
        
        view.weatherImageView.image = UIImage(systemName: "sun.max.fill")
        view.weatherImageView.contentMode = .scaleAspectFit
        view.weatherImageView.tintColor = .white
        view.weatherImageView.frame = CGRect(x: view.frame.width * 3 / 5,
                                             y: view.frame.height / 27,
                                             width: view.frame.height / 27 * 4,
                                             height: view.frame.height / 27 * 4)
        
        view.cityLabel.frame = CGRect(x: 10,
                                      y: view.weatherImageView.frame.maxY + 10,
                                      width: labelWidth,
                                      height: view.frame.height / 27 * 2.3)
        view.cityLabel.textColor = .black
        view.cityLabel.textAlignment = .center
        view.cityLabel.numberOfLines = 0
        view.cityLabel.font = UIFont.systemFont(ofSize: CGFloat(view.cityLabel.frame.height - 5), weight: .bold)
        
        view.temperatureLabel.frame = CGRect(x: 10,
                                             y: view.cityLabel.frame.maxY + 10,
                                             width: labelWidth,
                                             height: view.frame.height / 27)
        view.temperatureLabel.textColor = .black
        view.temperatureLabel.textAlignment = .center
        view.temperatureLabel.numberOfLines = 0
        view.temperatureLabel.font = UIFont.systemFont(ofSize: CGFloat(view.cityLabel.frame.height / 2), weight: .medium)

        let halfWidth = (labelWidth - 20) / 2
        
        view.sunriseImageView.image = UIImage(systemName: "sunrise.fill")
        view.sunriseImageView.contentMode = .scaleAspectFit
        view.sunriseImageView.tintColor = .black
        view.sunriseImageView.frame = CGRect(x: 10 + (halfWidth - 25) / 2, // Центрируем относительно половины
                                             y: view.temperatureLabel.frame.maxY + 10,
                                             width: 25,
                                             height: 25)
        
        view.sunriseLabel.frame = CGRect(x: 10,
                                         y: view.sunriseImageView.frame.maxY + 5, // Располагаем под иконкой
                                         width: halfWidth,
                                         height: view.frame.height / 27)
        view.sunriseLabel.textColor = .black
        view.sunriseLabel.textAlignment = .center
        view.sunriseLabel.numberOfLines = 0
        view.sunriseLabel.font = UIFont.systemFont(ofSize: CGFloat(view.cityLabel.frame.height / 2), weight: .medium)

        view.sunsetImageView.image = UIImage(systemName: "sunset.fill")
        view.sunsetImageView.contentMode = .scaleAspectFit
        view.sunsetImageView.tintColor = .black
        view.sunsetImageView.frame = CGRect(x: 10 + halfWidth + 20 + (halfWidth - 25) / 2, // Центрируем относительно правой половины
                                            y: view.temperatureLabel.frame.maxY + 10,
                                            width: 25,
                                            height: 25)
        
        view.sunsetLabel.frame = CGRect(x: 10 + halfWidth + 20,
                                        y: view.sunsetImageView.frame.maxY + 5, // Располагаем под иконкой
                                        width: halfWidth,
                                        height: view.frame.height / 27)
        view.sunsetLabel.textColor = .black
        view.sunsetLabel.textAlignment = .center
        view.sunsetLabel.numberOfLines = 0
        view.sunsetLabel.font = UIFont.systemFont(ofSize: CGFloat(view.cityLabel.frame.height / 2), weight: .medium)
        

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
        UIView.animate(withDuration: 0.3) {
            for viewNr in 0..<self.innerViewsOnLeft.count{
                self.innerViewsOnLeft[viewNr].frame.origin.x = -self.mainInnerViewPosition.width * CGFloat(self.innerViewsOnLeft.count - viewNr)
            }
            
            self.viewController.mainInnerView.frame = self.mainInnerViewPosition
            for viewNr in 0..<self.innerViewsOnRight.count{
                self.innerViewsOnRight[viewNr].frame.origin.x = self.constants.motherViewWidth + self.mainInnerViewPosition.width * CGFloat(viewNr)
            }
            self.viewController.mainInnerView.isUserInteractionEnabled = true
            self.viewController.mainInnerView.addGestureRecognizer(self.viewController.panGesture)
            for i in 0..<self.viewController.container.subviews.count{
                if i == self.viewController.mainInnerView.viewNumber{
                    let whiteImage = self.viewController.container.subviews[i] as! UIImageView
                    whiteImage.tintColor = .white
                }else{
                    let blackImage = self.viewController.container.subviews[i] as! UIImageView
                    blackImage.tintColor = .black
                }
            }
            self.updateHeart()
        }
        
    }
    
    
    
    func convertUnixTimeToReadable(_ timestamp: Int, _ timezone : Int = 0) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp + timezone))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone.current
        return formatter.string(from: date)
    }
}
