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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        
        
    }
    
//    MARK: - Functions
    
    
    func setUpView() {
        
        tableView.dataSource = self
        tableView.delegate = self

        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(logOutButtonClicked))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: UIBarButtonItem.Style.plain, target: self, action:  #selector(addButtonclicked))
        
        
        
        
        
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
        
    }

    

}

extension PlacesVC: UITableViewDataSource {



}

extension PlacesVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        var content = cell.defaultContentConfiguration()




        cell.contentConfiguration = content
        return cell
    }


}
