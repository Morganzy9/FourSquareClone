//
//  DetailVC.swift
//  FourSquareClone
//
//  Created by Ислам Пулатов on 6/12/23.
//

import UIKit
import MapKit

class DetailVC: UIViewController {
    
//    MARK: - @IBOutlet`s
    
    @IBOutlet var detailImageView: UIImageView!
    
    @IBOutlet var placeNameLabel: UILabel!
    
    @IBOutlet var placeTypeLabel: UILabel!
    
    @IBOutlet var placeAtmosphereLabel: UILabel!
    
    @IBOutlet var mapView: MKMapView!
    
//    MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        
    }
    
//    MARK: Functions
    
    func setUpView() {
        
        
        
    }
    

}
