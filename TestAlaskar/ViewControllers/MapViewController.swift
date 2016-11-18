//
//  MapViewController.swift
//  TestAlaskar
//
//  Created by Mariya on 17.11.16.
//  Copyright © 2016 Kilograpp. All rights reserved.
//

import UIKit
import GoogleMaps

final class MapViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    fileprivate let locationManager = CLLocationManager()
    fileprivate var pointArray: [Point]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        setupMapView()
    }
    @IBAction func updatePointArray(_ sender: Any) {
        showLocations()
    }
}

private protocol ShowLocations {
    func showMyLocation(location: CLLocationCoordinate2D)
    func showLocations()
}

private protocol Setup {
    func setupLocationManager()
    func setupMapView()
}

//MARK: - ShowLocations
extension MapViewController: ShowLocations {
    fileprivate func showMyLocation(location: CLLocationCoordinate2D) {
        self.mapView.animateToLocation(location, slowly: true) {self.showLocations()}
    }
    
    fileprivate func showLocations() {
        self.mapView.clear()
        guard let location = self.locationManager.location else {self.showAlert(title: "unable_determine_location".localized,
                                                                        message: "if_testing_on_simulator_including_determination_location".localized); return }
        self.pointArray = FormPointArrayService.sharedInstance.configureArray(map: self.mapView, userLocation: location.coordinate)
        guard let pointArray = self.pointArray else { return }
        pointArray.forEach{
            let position = CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)
            let marker = GMSMarker(position: position)
            marker.icon = GMSMarker.markerImage(for: location.coordinate, targetLocation: position)
            marker.map = self.mapView
            marker.userData = $0
        }
    }
}

//MARK: - Setup
extension MapViewController: Setup {
    fileprivate func setupLocationManager() {
        self.mapView.clear()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
    }
    
    fileprivate func setupMapView() {
        let camera = GMSCameraPosition.camera(withLatitude: Constants.CoordinateMoscow.Latitude,
                                                 longitude: Constants.CoordinateMoscow.Longitude,
                                                      zoom: Float(Constants.Zoom.First))
        self.mapView.camera = camera
        self.mapView.delegate = self
        self.mapView.isMyLocationEnabled = true
    }
}

//MARK: - GMSMapViewDelegate
extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let distance = GMSGeometryDistance((self.locationManager.location?.coordinate)!, marker.position)
        let title = (distance <= Constants.Radius.Min) ? "near_marker".localized : "away_marker".localized
        self.showAlert(title: title)
        return true
    }
}

//MARK: - CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        self.showMyLocation(location: locations.last!.coordinate)
    }
}
