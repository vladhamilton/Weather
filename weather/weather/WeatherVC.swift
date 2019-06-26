//
//  ViewController.swift
//  weather
//
//  Created by Vladyslav Kolomiets on 6/25/19.
//  Copyright © 2019 Vladyslav Kolomiets. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController {
  
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var currentTempLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var currentWeatherImage: UIImageView!
  @IBOutlet weak var currentWeatherTypeLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  
  let locationManager = CLLocationManager()
  var currentLocation: CLLocation!
  
  var currentWeather: CurrentWeather!
  var forecast: Forecast!
  var forecasts = [Forecast]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //locationManager.startMonitoringSignificantLocationChanges()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    currentWeather = CurrentWeather()
    setupLocationManager()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    locationAuthStatus()
  }
}

extension WeatherVC: UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return forecasts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
      
      let forecast = forecasts[indexPath.row]
      cell.configureCell(forecast: forecast)
      return cell
    } else {
      return WeatherCell()
    }
  }
  
  func updateMainUI() {
    dateLabel.text = currentWeather.date
    currentTempLabel.text = String(currentWeather.currentTemp)
    currentWeatherTypeLabel.text = currentWeather.weatherType
    locationLabel.text = currentWeather.cityName
    currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
  }
  
  //MARK: Downloading forecast weather data for TableView
  func downloadForecastData(completed: @escaping DownloadComplete) {
    
    Alamofire.request(FORECAST_URL).responseJSON { response in
      let result = response.result
      
      if let dict = result.value as? Dictionary<String, AnyObject> {
        
        if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
          
          for obj in list {
            let forecast = Forecast(weatherDict: obj)
            self.forecasts.append(forecast)
            print(obj)
          }
          self.forecasts.remove(at: 0)
          self.tableView.reloadData()
        }
      }
      completed()
    }
  }
  
//  func locationManager(_ manager: CLLocationManager, didFailWithError error: Swift.Error) {
//    print("error:: \(error.localizedDescription)")
//  }
//
//  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//    if status == .authorizedWhenInUse {
//      locationManager.requestLocation()
//    }
//  }
//
//  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//    if locations.first != nil {
//      print("location:: (location)")
//    }
//  }
  
  func locationAuthStatus() {
    if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
      currentLocation = locationManager.location
      Location.sharedInstance.latitude = currentLocation.coordinate.latitude
      Location.sharedInstance.longitude = currentLocation.coordinate.longitude
      currentWeather.downloadWeatherDetails {
        self.downloadForecastData {
          self.updateMainUI()
        }
      }
    } else {
      locationManager.requestWhenInUseAuthorization()
      locationAuthStatus()
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error)
  }
}


//MARK: - Localiton Setup
extension WeatherVC {
  
  func setupLocationManager() {
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
  }
}
