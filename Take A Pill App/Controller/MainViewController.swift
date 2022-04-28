//
//  MainViewController.swift
//  Take A Pill App
//
//  Created by Maciej Sałuda on 21/02/2022.
//

import UIKit
import Firebase

class MainViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    var medicines : [Medicine] = []
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func AddPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "MainToAdd", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MedicineCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        loadMeds()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func loadMeds() {
        
        db.collection("medicines").addSnapshotListener { (snapshot, error) in
            self.medicines = []
            if error != nil {
                print (error?.localizedDescription)
            }
            if snapshot?.isEmpty != true && snapshot != nil
            {
                for document in snapshot!.documents {
                    let data = document.data()
                    let docId = document.documentID
                    if let med = data["medicine"] as? String,
                       let number = data["medQuantity"] as? String
                    { let newMed = Medicine(medicine: med, medQuantity: number, id: docId )
                        self.medicines.append(newMed)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            
                        }
                        
                    }
                }
            }
        }
        
    }
    
}

extension MainViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MedicineCell
        let medicine = medicines[indexPath.row]
        cell.nameLabel.text = medicine.medicine
        cell.quantityLabel.text = medicine.medQuantity
        cell.idLabel.text = medicine.id
        return cell
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicines.count
        
    }
    
}
