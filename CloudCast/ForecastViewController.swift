//
//  ForecastViewController.swift
//  CloudCastTests
//
//  Created by Ngoc Nhu Y Banh on 2023-10-02.
//

import UIKit

class ForecastViewController: UIViewController {
    
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
   
    @IBOutlet weak var forecastImageView: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    private var forecasts = [WeatherForecast]() // tracks all the possible forecasts
    private var selectedForecastIndex = 0 // tracks which forecast is being shown, defaults to 0
    
    //Function override for the view controller,
    // it will fire when the view finished loading for the first time
    override func viewDidLoad() {
        super.viewDidLoad()
        //let fakeData = WeatherForecast(temperature: 13.0, date: Date(), weatherCode: .partlyCloudy)
        forecasts = createMockData()
        configure(with: forecasts[selectedForecastIndex])
    }
    
    private func configure(with forecast: WeatherForecast) {
        forecastImageView.image = forecast.weatherCode.image
        descriptionLabel.text = forecast.weatherCode.description
        temperatureLabel.text = "\(forecast.temperature)°F"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateLabel.text = dateFormatter.string(from: forecast.date)
      }
    
    // Returns an array of fake WeatherForecast data models to show
        private func createMockData() -> [WeatherForecast] {
            // This is just using the Calendar API to get a few random dates
            let today = Date()
            var dateComponents = DateComponents()
            dateComponents.day = 1
            let tomorrow = Calendar.current.date(byAdding: dateComponents, to: today)!
            let dayAfterTomorrow = Calendar.current.date(byAdding: dateComponents, to: tomorrow)!
            // Create a few mock data to show
            let mockData1 = WeatherForecast(windSpeed: 3.3,
                                            weatherCode: .violentRainShowers,
                                            precipitation: 33.3,
                                            temperature: 59.5,
                                            date:today)
            let mockData2 = WeatherForecast(windSpeed: 3.7,
                                            weatherCode: .fog,
                                            precipitation: 13.3,
                                            temperature: 65.5,
                                            date: tomorrow)
            let mockData3 = WeatherForecast(windSpeed: 2.8,
                                            weatherCode: .partlyCloudy,
                                            precipitation: 23.3,
                                            temperature: 49.5,
                                            date: dayAfterTomorrow)
            return [mockData1, mockData2, mockData3]
        }
    
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        selectedForecastIndex = max(0, selectedForecastIndex - 1) // don't go lower than 0 index
        configure(with: forecasts[selectedForecastIndex]) // change the forecast shown in the UI
    }
    
    
    @IBAction func didForwardButton(_ sender: UIButton) {
        selectedForecastIndex = min(forecasts.count - 1, selectedForecastIndex + 1) // don't go higher than the number of forecasts
        configure(with: forecasts[selectedForecastIndex]) // change the forecast shown in the UI
    }
    
}

