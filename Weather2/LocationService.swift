//
//  LocationService.swift
//  Weather2
//
//  Created by Anastasiia on 09.08.2022.
//

import Foundation
import CoreLocation


struct Location {
    let latitude: Double
    let longtitude: Double
}

protocol LocationServiceProtocol {
    func startUpdatingLocation()
    var delegate: LocationServiceDelegate? { get set }
}

protocol LocationServiceDelegate: AnyObject {
    func locationManager(didUpdateLocations location: Location)
}

final class LocationService: NSObject, LocationServiceProtocol {
    let manager = CLLocationManager()
    weak var delegate: LocationServiceDelegate?

    func startUpdatingLocation() {
        manager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            manager.pausesLocationUpdatesAutomatically = false
            manager.startUpdatingLocation()
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            let location = Location(latitude: lastLocation.coordinate.latitude, longtitude: lastLocation.coordinate.longitude)
            delegate?.locationManager(didUpdateLocations: location)
            //print(lastLocation.coordinate.latitude, lastLocation.coordinate.longitude)

        }
    }
}
