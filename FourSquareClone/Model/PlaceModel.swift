//
//  Place.swift
//  FourSquareClone
//
//  Created by Ислам Пулатов on 6/14/23.
//

import Foundation
import UIKit

class PlaceModel {
    
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeAtmosphere = ""
    var placetype = ""
    var image = UIImage()
    
    private init() {}
    
}
