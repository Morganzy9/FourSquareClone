//
//  DetailVC.swift
//  FourSquareClone
//
//  Created by Ислам Пулатов on 6/12/23.
//

import UIKit
import MapKit
import Parse

class DetailVC: UIViewController {
    
    //    MARK: - @IBOutlet`s
    
    @IBOutlet var detailImageView: UIImageView!
    
    @IBOutlet var placeNameLabel: UILabel!
    
    @IBOutlet var placeTypeLabel: UILabel!
    
    @IBOutlet var placeAtmosphereLabel: UILabel!
    
    @IBOutlet var mapView: MKMapView!
    
    //    MARK: - Variables
    
    var choosenPlaceId = ""
    
    var placeLatitude = Double()
    var placeLongitude = Double()
    
    //    MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        
    }
    
    //    MARK: Functions
    
    func setUpView() {
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: UIBarButtonItem.Style.done, target: self, action: #selector(backButton))
        
        settingPlaceType()
        
    }
    
    @objc func backButton() {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    func settingPlaceType() {
        
        let query = PFQuery(className: "Places")
        
        query.whereKey("objectId", contains: choosenPlaceId)
        
        query.findObjectsInBackground { objects, error in
            
            if let error = error {
                
                self.makeAlert(title: "Error", message: error.localizedDescription)
                
            } else {
                
                //                OBJECTS
                
                guard let objects = objects, !objects.isEmpty else {
                    print("Error in objects")
                    
                    return
                }
                
                let choosenPLaceObject = objects[0]
                
                
                guard let imageData = choosenPLaceObject.object(forKey: "image") as? PFFileObject else {
                    
                    
                    
                    return
                }
                
                guard let name = choosenPLaceObject.object(forKey: "name") as? String else {
                    
                    print("Error in Name")
                    
                    return
                }
                
                guard let type = choosenPLaceObject.object(forKey: "type") as? String else {
                    
                    print("Error in type")
                    
                    return
                }
                
                guard let atmosphere = choosenPLaceObject.object(forKey: "atmosphere") as? String else {
                    
                    print("Error in atmosphere")
                    
                    return
                }
                
                guard let latitude = choosenPLaceObject.object(forKey: "latitude") as? String else {
                    
                    print("Error in latitude")
                    
                    return
                }
                
                guard let longitude = choosenPLaceObject.object(forKey: "longitude") as? String else {
                    
                    print("Error in longitude")
                    
                    return
                }
                
                
                
                imageData.getDataInBackground { data, error in
                    
                    if let error = error {
                        
                        self.makeAlert(title: "Error", message: error.localizedDescription)
                        
                    } else {
                        
                        guard let data = data else {
                            
                            print("Error in data")
                            
                            return
                        }
                        
                        self.detailImageView.image = UIImage(data: data)
                        
                    }
                    
                }
                
                
                self.placeNameLabel.text = "Place type: \(name)"
                self.placeTypeLabel.text = "Place type: \(type)"
                self.placeAtmosphereLabel.text = "Place atmosphere: \(atmosphere)"
                
                guard let latitudeDoubleValue = Double(latitude) else {
                    
                    print("Error in latitudeDoubleValue")
                    
                    return
                }
                
                guard let longitudeDoubleValue = Double(longitude) else {
                    
                    print("Error in longitudeDoubleValue")
                    
                    return
                }
                
                self.placeLatitude = latitudeDoubleValue
                self.placeLongitude = longitudeDoubleValue
                
                
                //                MAPS
                
                
                let location = CLLocationCoordinate2D(latitude: self.placeLatitude, longitude: self.placeLongitude)
                
                let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                
                let region = MKCoordinateRegion(center: location, span: span)
                
                self.mapView.setRegion(region, animated: true)
                
                
                let annotation = MKPointAnnotation()
                
                annotation.coordinate = location
                
                annotation.title = self.placeNameLabel.text
                annotation.subtitle = self.placeTypeLabel.text
                
                self.mapView.addAnnotation(annotation)
                
            }
            
        }
        
    }
    
    func makeAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
    
    
}
