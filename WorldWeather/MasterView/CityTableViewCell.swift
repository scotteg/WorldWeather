//
//  CityTableViewCell.swift
//  WorldWeather
//
//  Created by Scott Gardner on 10/25/14.
//  Copyright (c) 2014 RayWenderlich. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {
  
  @IBOutlet weak var cityImageView: UIImageView!
  @IBOutlet weak var cityNameLabel: UILabel!
  var cityWeather: CityWeather? {
    didSet {
      configureCell()
    }
  }
  
  private func configureCell() {
    cityImageView.image = cityWeather?.cityImage
    cityNameLabel.text = cityWeather?.name
  }
  
}
