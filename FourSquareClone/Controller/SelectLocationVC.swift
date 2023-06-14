//
//  SelectLocationVC.swift
//  FourSquareClone
//
//  Created by Ислам Пулатов on 6/12/23.
//

import UIKit
import MapKit



class SelectLocationVC: UIViewController {
    
//    MARK: - @IBOutlet`s

    @IBOutlet var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
//    MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        
    }
    
//    MARK: - Functions
    
    func setUpView() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(savePlace))
        
        mapDelegate()
        
        setUpLocation()
        
        
    }
    
    @objc func savePlace() {
        
        
        
    }

    

}

//  MARK: - Extension`s

extension SelectLocationVC: MKMapViewDelegate {

    func mapDelegate() {
        
        mapView.delegate = self
        
    }


}

extension SelectLocationVC: CLLocationManagerDelegate {
    
    
    
    
    func setUpLocation() {
        
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        locationManager.startUpdatingLocation()
        
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        
//        Zoom level defines span values
        
        let span = MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: true)
        
    }
    
    
}
