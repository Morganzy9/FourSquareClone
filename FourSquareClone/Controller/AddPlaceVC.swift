//
//  AddPlaceVC.swift
//  FourSquareClone
//
//  Created by Ислам Пулатов on 6/12/23.
//

import UIKit
import Photos
import PhotosUI

class AddPlaceVC: UIViewController {
    
    //    MARK: - @IBOutlet`s
    
    @IBOutlet var placeNameTextField: UITextField!
    
    @IBOutlet var placeTypeTextField: UITextField!
    
    
    @IBOutlet var placeAtmosphereTextField: UITextField!
    
    @IBOutlet var choosenImage: UIImageView!
    
    //    MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        
        
    }
    
    //    MARK: - Functions
    
    func setUpView() {
        
        //        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.camera, target: self, action: #selector(presentPhotoLibrary))
        
        
        
        choosenImage.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(presentPhotoLibrary))
        
        choosenImage.addGestureRecognizer(gestureRecognizer)
        
        
    }
    
    @objc func presentPhotoLibrary() {
        
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.images
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        present(picker, animated: true)
        
    }
    
    
    //    MARK: - @IBAction`s
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        
        if placeNameTextField.text != "" && placeTypeTextField.text != "" && placeAtmosphereTextField.text != "" {

            if let uploadedImage = choosenImage.image {
                
                let placeModel = PlaceModel.sharedInstance
                
                placeModel.placeName = placeNameTextField.text!
                placeModel.placetype = placeTypeTextField.text!
                placeModel.placeAtmosphere = placeAtmosphereTextField.text!
                placeModel.image = uploadedImage
                
            }
            
            performSegue(withIdentifier: "toSelectLocation", sender: nil)

            
        } else {
            
            let alert = UIAlertController(title: "Error", message: "Missing Place Name/Type/Atmosphere", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
            
            alert.addAction(okButton)
            
            present(alert, animated: true)
            
        }
        
        
        
    }
    
    
    
}

//  MARK: - Extension`s

extension AddPlaceVC: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        
        
        for item in results {
            
            item.itemProvider.loadObject(ofClass: UIImage.self) { selectedImage, Error in
                
                guard let image = selectedImage as? UIImage else {
                    
                    print("Error in selectedImage")
                    
                    return
                }
                
                DispatchQueue.main.async {
                    self.choosenImage.image = image
                }
                
            }
            
        }
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
    
    
}
