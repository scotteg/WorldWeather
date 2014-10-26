/*
* Copyright (c) 2014 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

@objc protocol CityWeatherContainer {
  var cityWeather: CityWeather? { get set }
}


class WeatherTextViewController: UIViewController, CityWeatherContainer {
  
  // MARK: - IBOutlets
  @IBOutlet weak var cityNameLabel: UILabel!
  @IBOutlet weak var temperatureLabel: UILabel!
  
  // MARK: - Properties
  var cityWeather: CityWeather? {
    didSet {
      if isViewLoaded() {
        configureView()
        provideDataToChildViewControllers()
      }
    }
  }
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    configureView()
    
    let traitOverride = UITraitCollection(horizontalSizeClass: .Compact)
    for vc in childViewControllers as [UIViewController] {
      setOverrideTraitCollection(traitOverride, forChildViewController: vc)
    }
  }
  
  // MARK: - Utility methods
  private func configureView() {
    if let cityWeather = cityWeather {
      cityNameLabel.text = cityWeather.name
      temperatureLabel.text = "\(cityWeather.weather[0].status.temperature)"
    }
  }
  
  private func provideDataToChildViewControllers() {
    for vc in childViewControllers {
      if let weeklyWeatherContainer = vc as? WeeklyWeatherContainer {
        if let weeklyWeather = cityWeather?.weather {
          weeklyWeatherContainer.dailyWeather = weeklyWeather
        }
      }
    }
  }
  
}
