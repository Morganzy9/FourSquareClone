//
//  PlacesVC.swift
//  FourSquareClone
//
//  Created by Ислам Пулатов on 6/10/23.
//

import UIKit
import Parse

class PlacesVC: UIViewController {
    
//    MARK: - @IBOutlet`s

    @IBOutlet var tableView: UITableView!
    
    var placeNameArray = [String]()
    var placeIdArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        
        
    }
    
//    MARK: - Functions
    
    
    func setUpView() {
        
        tableView.dataSource = self
        tableView.delegate = self

        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonclicked))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: UIBarButtonItem.Style.plain, target: self, action:  #selector(logOutButtonClicked))
        
        getDataFromParse()
        
        
        
    }
    /*
    func getDataFromParse() {
        let query = PFQuery(className: "Places")
        
        query.findObjectsInBackground { objects, error in
            if let error = error {
                self.makeAlert(title: "Error", message: error.localizedDescription )
            } else {
                guard let objects = objects else {
                    print("Error in Objects")
                    return
                }
                
                self.placeNameArray.removeAll(keepingCapacity: false)
                self.placeId.removeAll(keepingCapacity: false)
                
                for object in objects {
                    if let name = object.object(forKey: "name") as? String,
                       let placeId = object.objectId as? String {
                        self.placeNameArray.append(name)
                        self.placeId.append(placeId)
                    }
                }
                
                self.tableView.reloadData()
            }
        }
    }
*/
    
    func getDataFromParse() {

        let query = PFQuery(className: "Places")

        query.findObjectsInBackground { objects, error in

            if let  error = error {

                self.makeAlert(title: "Error", message: error.localizedDescription)

            } else {

                guard let objects = objects else {

                    print("Error in Objects")

                    return
                }

                self.placeNameArray.removeAll(keepingCapacity: false)
                self.placeIdArray.removeAll(keepingCapacity: false)

                for object in objects {
                    
                    guard let name = object.object(forKey: "name") as? String,
                          let placeId = object.objectId else {
 
                        print("Error in name")

                        return
                    }

                    self.placeNameArray.append(name)
                    self.placeIdArray.append(placeId)
                    
                }
                
                

                self.tableView.reloadData()

            }

        }

    }
    
    func makeAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
    
    
    
    
//    MARK: - @objc Functions
    
    @objc func logOutButtonClicked() {
        
        PFUser.logOutInBackground { Error in
            
            if Error != nil {
                
                self.makeAlert(title: "Error", message: Error?.localizedDescription ?? "Unknown Error")
                
            } else {
                
                self.performSegue(withIdentifier: "toSignINVC", sender: nil)
                
            }
            
        }
    
        
    }
    
    @objc func addButtonclicked() {
        
        performSegue(withIdentifier: "toAddPlaceVC", sender: nil)
        
    }

    

}

extension PlacesVC: UITableViewDataSource {



}

extension PlacesVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeNameArray.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        var content = cell.defaultContentConfiguration()
        
        content.text = placeNameArray[indexPath.row]

        cell.contentConfiguration = content
        return cell
    }


}
