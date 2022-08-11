//
//  ViewController.swift
//  Weather2
//
//  Created by Dima  on 01.08.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak private var cityLabel: UILabel!
    @IBOutlet weak private var tempLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var iconView: UIImageView!
    @IBOutlet weak private var backgroundView: UIView!
    @IBOutlet weak private var dayLabel: UILabel!
    
    var locationService: LocationServiceProtocol?
    var weatherData = WeatherData()
    let gradientLayer = CAGradientLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationService = LocationService()
        locationService?.delegate = self
        locationService?.startUpdatingLocation()
        
    }
    
    fileprivate func updateView() {
        cityLabel.text = weatherData.name
        tempLabel.text = "\(weatherData.main.temp.description)º"
        descriptionLabel.text = weatherData.weather[0].description
        iconView.image = UIImage(named: weatherData.weather[0].icon)
        dateToday()
        backgroundView.layer.addSublayer(gradientLayer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBlueGradientBackground()
    }
    
    fileprivate func updateWeatherInfo(latitude: Double, longtitude: Double) {
        let session = URLSession.shared
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude.description)&lon=\(longtitude.description)&appid=b6103274efbe639f6a87ffb6d8902faf&units=metric")!
        
        let tast = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print("DataTask error: \(error!.localizedDescription)")
                return
            }
            
            do {
                self.weatherData = try JSONDecoder().decode(WeatherData.self, from: data!)
                DispatchQueue.main.async {
                    self.updateView()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        tast.resume()
    }
    
    fileprivate func dateToday(){
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        self.dayLabel.text = dateFormatter.string(from: date)
    }
    
    fileprivate func setBlueGradientBackground(){
        let topColor = UIColor(red: 95.0/255.0, green: 165.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 72.0/255.0, green: 114.0/255.0, blue: 184.0/255.0, alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
        
    }
    fileprivate func setGrayGradientBackground(){
        let topColor = UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 72.0/255.0, green: 72.0/255.0, blue: 72.0/255.0, alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
        
    }
}

extension ViewController: LocationServiceDelegate {
    func locationManager(didUpdateLocations location: Location) {
        updateWeatherInfo(latitude: location.latitude, longtitude: location.longtitude)
        
    }
}

