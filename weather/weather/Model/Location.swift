//
//  Location.swift
//  weather
//
//  Created by Vladyslav Kolomiets on 6/25/19.
//  Copyright © 2019 Vladyslav Kolomiets. All rights reserved.
//

import CoreLocation

class Location {
  static var sharedInstance = Location()
  private init() {}
  
  var latitude: Double!
  var longitude: Double!
}
