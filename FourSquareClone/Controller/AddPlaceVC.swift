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
    
    @IBOutlet var placeTyprTextField: UITextField!
    
    
    @IBOutlet var placeAtmosphereTextField: UITextField!
    
    @IBOutlet var uploadIMageView: UIImageView!
    
//    MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        
        
    }
    
//    MARK: - Functions
    
    func setUpView() {
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.camera, target: self, action: #selector(presentPhotoLibrary))
        
        
        
        uploadIMageView.isUserInteractionEnabled = true

        uploadIMageView.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(presentPhotoLibrary)))

        
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
        
            performSegue(withIdentifier: "toSelectLocation", sender: nil)
        
    }
    
    

}

//  MARK: - Extension`s

extension AddPlaceVC: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
        dismiss(animated: true, completion: nil)
        
        for item in results {
            
            item.itemProvider.loadObject(ofClass: UIImage.self) { selectedImage, Error in
                
                guard let image = selectedImage as? UIImage else {
                    
                    print("Error in selectedImage")
                    
                    return
                }
                
                DispatchQueue.main.async {
                    self.uploadIMageView.image = image
                }
                
            }
            
        }
        
        
    }
    
    
    
}
