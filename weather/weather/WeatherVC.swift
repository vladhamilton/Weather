//
//  ViewController.swift
//  weather
//
//  Created by Vladyslav Kolomiets on 6/25/19.
//  Copyright © 2019 Vladyslav Kolomiets. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController {

  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var currentTempLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var currentWeatherImage: UIImageView!
  @IBOutlet weak var currentWeatherTypeLabel: UILabel!
  @IBOutlet weak var tableview: UITableView!
  
  var currentWeather = CurrentWeather()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableview.delegate = self
    tableview.dataSource = self
    currentWeather.downloadWeatherDetails {
      
    }
  }
}

extension WeatherVC: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 6
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
    
    return cell
  }
}
