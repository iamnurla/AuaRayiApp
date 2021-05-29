//
//  WeatherViewController.swift
//  AuaRayiApp
//
//  Created by Yersultan Nalikhan on 17.05.2021.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    //MARK: - Variables
    
    var weatherView = WeatherView()
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    

    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = weatherView
        
        weatherView.locationButton.addTarget(self, action: #selector(locationBtnPressed), for: .touchUpInside)
        weatherView.searchButton.addTarget(self, action: #selector(searchBtnPressed), for: .touchUpInside)
        weatherView.searchTextfield.delegate = self
        
        weatherManager.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        


        
    }
    
    //MARK: - Action Functions
    
    @objc func locationBtnPressed() {
        locationManager.requestLocation()

    }
    
    @objc func searchBtnPressed() {
        weatherView.searchTextfield.endEditing(true)
        
    }
    
    
    
}


//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        weatherView.searchTextfield.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = weatherView.searchTextfield.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        weatherView.searchTextfield.text = ""
        
    }
}

//MARK: - WeatherManagerDelegate


extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.weatherView.temperatureLabel.text = weather.temperatureString + "°C"
            self.weatherView.conditionView.image = UIImage(systemName: weather.conditionName)
            self.weatherView.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - CLLocationManagerDelegate


extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            self.weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
