//
//  SelectLocationVC.swift
//  FourSquareClone
//
//  Created by Ислам Пулатов on 6/12/23.
//

import UIKit
import MapKit
import Parse



class SelectLocationVC: UIViewController {
    
//    MARK: - @IBOutlet`s

    
    @IBOutlet var mapView: MKMapView!
    
    
//    MARK: - Variables
    
    let locationManager = CLLocationManager()
    
//    MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        
    }
    
//    MARK: - Functions
    
    func setUpView() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButton))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(savePlace))
        
        mapDelegate()
        setUpLocation()
        
        
    }
    
    @objc func backButton() {
        
        self.dismiss(animated: true)
        
    }
    
    @objc func savePlace() {
        
        let placeModel = PlaceModel.sharedInstance
        
        let object = PFObject(className: "Places")
        
        let uuid = UUID().uuidString
        
        
        object["name"] = placeModel.placeName
        object["type"] = placeModel.placetype
        object["atmosphere"] = placeModel.placeAtmosphere
        object["latitude"] = placeModel.placeLatitude
        object["longitude"] = placeModel.placeLongitude
        
        guard let imageData = placeModel.image.jpegData(compressionQuality: 0.5) else {
            
            print("Error in ImageData")
            
            return
        }
        
        object["image"] = PFFileObject(name: "\(uuid).jpeg",data: imageData)
        
        object.saveInBackground { success, Error in
            
            if Error != nil {
                
                let alert = UIAlertController(title: "Error", message: Error?.localizedDescription ?? "Unknown Error", preferredStyle: UIAlertController.Style.alert)
                
                let ok = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
                
                alert.addAction(ok)
                
                self.present(alert, animated: true)
                
            } else {
                
                self.performSegue(withIdentifier: "fromSelectLocationVCtoPlacesVC", sender: nil)
                
            }
            
        }
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
            
            placeModel.placeLatitude = String(coordinates.latitude)
            placeModel.placeLongitude = String(coordinates.longitude)
            
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
