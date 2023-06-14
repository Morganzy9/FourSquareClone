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
    
    var chooseLatitude = ""
    var chooseLongitude = ""
    
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
        
        let makePinRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(choosenLocation(gestureRecognizer: ) ))
        makePinRecognizer.minimumPressDuration = 2
        
        mapView.addGestureRecognizer(makePinRecognizer)
        
    }
    
    @objc func choosenLocation(gestureRecognizer: UIGestureRecognizer) {
        
        let placeModel = PlaceModel.sharedInstance
        
        if gestureRecognizer.state == UIGestureRecognizer.State.began {
            
            let touches = gestureRecognizer.location(in: self.mapView)
            
            let coordinates = self.mapView.convert(touches, toCoordinateFrom: self.mapView)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            
            annotation.title = placeModel.placeName
            annotation.subtitle = placeModel.placetype
            
            chooseLatitude = String(coordinates.latitude)
            chooseLongitude = String(coordinates.longitude)
            
            mapView.addAnnotation(annotation)
            
        }
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        locationManager.startUpdatingLocation()
        
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        
//        Zoom level defines span values
        
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: true)
        
    }
    
    
}
