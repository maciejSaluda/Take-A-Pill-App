//
//  AddViewController.swift
//  Take A Pill App
//
//  Created by Maciej Sałuda on 22/02/2022.
//

import UIKit
import Firebase
import EventKit
import EventKitUI

class AddViewController: UIViewController, EKEventViewDelegate, EKEventEditViewDelegate {
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        controller.dismiss(animated: true, completion: nil)
        
    }
    
    func eventViewController(_ controller: EKEventViewController, didCompleteWith action: EKEventViewAction) {

    }
    
    
    let eventStore = EKEventStore()
    let db = Firestore.firestore()
    
    
    
    @IBOutlet weak var medicineName: UITextField!
    
    @IBOutlet weak var quantity: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        if let medName = medicineName.text, let amount = quantity.text {
            db.collection("medicines").addDocument(data: ["medicine" : medName, "medQuantity" : amount])
            { (error) in
                if let e = error {
                    print("There was an issue in saving data to Firestore, \(e)")
                } else {
                    print("Successfully saved data.")
                }
                DispatchQueue.main.async {
                    self.medicineName.text = ""
                    self.quantity.text = ""
                    
                }
                
            }
            
        }
        dismiss(animated: true) {
            self.performSegue(withIdentifier: "AddToMain", sender: UIButton.self)
        }
    }
    
    @IBAction func setUpReminder(_ sender: Any) {
        eventStore.requestAccess(to: .event) { granted, error in
            if error == nil {
                DispatchQueue.main.async {
                    self.presentEventVC()
                }
            }
        }
    }
    func presentEventVC() {
        
        let eventVC = EKEventEditViewController()
        eventVC.editViewDelegate = self
        eventVC.eventStore = EKEventStore()
        
        let event = EKEvent(eventStore: eventVC.eventStore)
        event.title = medicineName.text
        event.notes = quantity.text
        event.startDate = event.endDate
        event.isAllDay = false
        event.alarms = [EKAlarm.init()]
        event.startDate = Date()
        eventVC.event = event
        self.present(eventVC, animated: true, completion: nil)
    }
}
