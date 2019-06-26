//
//  WeatherCell.swift
//  weather
//
//  Created by Vladyslav Kolomiets on 6/25/19.
//  Copyright © 2019 Vladyslav Kolomiets. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
  
  @IBOutlet weak var weatherIcon: UIImageView!
  @IBOutlet weak var dayLabel: UILabel!
  @IBOutlet weak var weatherType: UILabel!
  @IBOutlet weak var highTemp: UILabel!
  @IBOutlet weak var lowTemp: UILabel!
  
  func configureCell(forecast: Forecast) {
    lowTemp.text = "\(forecast.lowTemp)°"
    highTemp.text = "\(forecast.highTemp)°"
    weatherType.text = forecast.weatherType
    weatherIcon.image = UIImage(named: forecast.weatherType)
    dayLabel.text = forecast.date
  }
}
