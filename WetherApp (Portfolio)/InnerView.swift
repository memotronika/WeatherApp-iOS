//
//  InnerView.swift
//  WetherApp (Portfolio)
//
//  Created by Anton Angel on 14/03/2025.
//

import UIKit


class InnerView: UIView {
    
    
    var viewNumber: Int!
    var cityLabel = UILabel()
    var temperatureLabel = UILabel()
    var humidityLabel = UILabel()
    var pressureLabel = UILabel()
    var sunriseLabel = UILabel()
    var sunsetLabel = UILabel()
    var windSpeedLabel = UILabel()
    var windDirection : Int!
    
    var weatherImageView = UIImageView(image: UIImage(systemName: "star.fill"))
    
    init(viewNumber: Int) {
        super.init(frame: .zero)
        cityLabel.text = "{Placeholder City}"
        temperatureLabel.text = "{placeholder temperature}"
        humidityLabel.text = "{placeholder humidity}"
        pressureLabel.text = "{pressure placeholder}"
        sunriseLabel.text = "{sunrise placeholder}"
        sunsetLabel.text = "{wind speed placeholder}"
        windDirection = 499
        
        self.viewNumber = viewNumber
        
           }
           
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
       }


