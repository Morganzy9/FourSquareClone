//
//  AddVC.swift
//  FourSquareClone
//
//  Created by Ислам Пулатов on 6/11/23.
//

// MARK: TO-DO: Make gesturerecognizer in ImageView

import UIKit
import Photos
import PhotosUI

class AddVC: UIViewController,  UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    
    
    
    
    //    MARK: - @IBOutlet`s
    
    @IBOutlet var placeNameTextField: UITextField!
    
    @IBOutlet var placeTypeTextField: UITextField!
    
    @IBOutlet var placeAtmossphereTextField: UITextField!
    
    @IBOutlet var chooseImabgeView: UIImageView!
    
    //    MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        
    }
    
    
    //    MARK: - Functions
    
    
    func setUpView() {
        
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(presentImagePicker))
        
//        chooseImabgeView.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(presentImagePicker)))
        
        
        
    }
    
    
    @objc func presentImagePicker() {
        
        print("LOLOLOLOLOLOALO")
        
        let vc = UIImagePickerController()
        
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = false
        
        present(vc, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let chosenImage = info[.originalImage] as? UIImage {
            chooseImabgeView.image = chosenImage
        }
        
        dismiss(animated: true)
        
        
    }
    
    
    
    
    //    MARK: - @IBAction`s
    
    @IBAction func nextButton(_ sender: Any) {
        
        
        
        
        
    }
    
    
    
    
}
/*
extension AddVC : PHPickerViewControllerDelegate {

    @objc func presentImagePicker() {
        
        var configuration = PHPickerConfiguration()
        
        configuration.filter = .any(of: [.images, .livePhotos])
        configuration.selectionLimit = 1
        
        
        let picker = PHPickerViewController(configuration: configuration)
        
        picker.delegate = self
        
        self.present(picker, animated: true)
        
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        dismiss(animated: true)
        
        for item in results {
            
            item.itemProvider.loadObject(ofClass: UIImage.self) { image, Error in
                
                if Error != nil {
                    
                    let alert = UIAlertController(title: "Error", message: Error?.localizedDescription ?? "Unknown Error", preferredStyle: .alert)
                    
                    let okButton = UIAlertAction(title: "Ok", style: .default)
                    
                    alert.addAction(okButton)
                    
                    self.present(alert, animated: true)
                    
                } else {
                    
                    
                    guard let choosenImage = image as? UIImage else {
                        
                        print("Error in Accessing Image!")
                        
                        return
                    }
                    DispatchQueue.main.async {
                        self.chooseImabgeView.image = choosenImage
                    }
                    
                }
                
            }
            
        }
        
    }
    

}

*/
