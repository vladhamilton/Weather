//
//  Extension.swift
//  weather
//
//  Created by Vladyslav Kolomiets on 6/26/19.
//  Copyright © 2019 Vladyslav Kolomiets. All rights reserved.
//

import Foundation

extension Date {
  func dayOfTheWeek() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    return dateFormatter.string(from: self)
  }
}
