//
//  ForecastViewController.swift
//  Weather2
//
//  Created by Dima  on 02.08.2022.
//

import UIKit

class ForecastViewController: UIViewController {

    @IBOutlet weak private var forecastTableView: UITableView!
    @IBOutlet weak private var citySearchBar: UISearchBar!
    let cellID = "CustomTableViewCell"
    var timer = Timer()
    var dataIsReady:Bool = false
    var forecastData:ForecastData! //{
//        didSet {
//            DispatchQueue.main.async {
//                self.forecastTableView.reloadData()
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        citySearchBar.delegate = self
        forecastTableView.delegate = self
        forecastTableView.dataSource = self
        //        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=Kiev&cnt=16&appid=3733254d74175f06737517581d91a336&units=metric"
    }
    
    fileprivate func updateSearchResults(for text: String) {
        let city = text
        timer.invalidate()
        if text.count > 1 {
            timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: {(timer) in
                self.updateForecastInfo(city: city, result: { (model) in
                    if model != nil {
                        self.dataIsReady = true
                        self.forecastData = model
                        self.forecastTableView.reloadData()
                    }
                })
            })
        }        
    }

    fileprivate func updateForecastInfo(city:String, result: @escaping ((ForecastData) -> ())) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/forecast"
        urlComponents.queryItems = [URLQueryItem(name: "q", value: city), URLQueryItem(name: "appid", value: "3733254d74175f06737517581d91a336"), URLQueryItem(name: "units", value: "metric")]
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"

        let tast = URLSession(configuration: .default)
        tast.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("DataTask error: \(error!.localizedDescription)")
                return
            }
            do {
                let model = try JSONDecoder().decode(ForecastData.self, from: data!)
                DispatchQueue.main.async {
                    print(String(bytes: data!, encoding: .utf8))
                    result(model)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataIsReady {
            return self.forecastData.list.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = forecastTableView.dequeueReusableCell(withIdentifier: cellID) as! CustomTableViewCell
               
        cell.cityLabel.text = self.forecastData.city.name
        cell.tempLabel.text = "\(self.forecastData.list[indexPath.row].main.temp.description)º"
        cell.dateLabel.text = self.forecastData.list[indexPath.row].dt_txt
        return cell
    }
}

extension ForecastViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateSearchResults(for: searchText)
    }
}
