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
    
//    MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        
    }
    
//    MARK: - Functions
    
    func setUpView() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(savePlace))
        
        setUpLocation()
        
        
        
    }
    
    @objc func savePlace() {
        
        
        
    }

    

}

//  MARK: - Extension`s

extension SelectLocationVC: CLLocationManagerDelegate {
    
    
    func setUpLocation() {
        
        
    }
    
    
}
