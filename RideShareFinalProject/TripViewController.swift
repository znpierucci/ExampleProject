//
//  TripViewController.swift
//  RideShareFinalProject
//
//  Created by sahand sadri on 12/13/17.
//  Copyright © 2017 Sahand Sadri. All rights reserved.
//

import UIKit
import CloudKit

class TripViewController: UIViewController {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var zip: UITextField!
    @IBOutlet weak var address2: UITextField!
    @IBOutlet weak var city2: UITextField!
    @IBOutlet weak var state2: UITextField!
    @IBOutlet weak var zip2: UITextField!
    @IBOutlet weak var departure: UITextField!
    @IBOutlet weak var carMake: UITextField!
    @IBOutlet weak var carModel: UITextField!
    @IBOutlet weak var license: UITextField!
    @IBOutlet weak var joinTripEmail: UITextField!
    
    
    let publicDatabase = CKContainer(identifier: "iCloud.edu.mail.missouri.RideShareFinalProject").publicCloudDatabase
    
    //let dateFormatter = DateFormatter()
    let dateFormatter: DateFormatter = { () -> DateFormatter in
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .long
        return formatter
    }()
    
    var trip: CKRecord?
    
    weak var tripDelegate: TripDelegate?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        firstName.delegate = self
        lastName.delegate = self
        email.delegate = self
        address.delegate = self
        city.delegate = self
        state.delegate = self
        zip.delegate = self
        address2.delegate = self
        city2.delegate = self
        state2.delegate = self
        zip2.delegate = self
        departure.delegate = self
        carMake.delegate = self
        carModel.delegate = self
        license.delegate = self
        
        firstName.text = trip?.object(forKey: "firstName") as? String
        lastName.text = trip?.object(forKey: "lasName") as? String
        email.text = trip?.object(forKey: "email") as? String
        address.text = trip?.object(forKey: "address") as? String
        city.text = trip?.object(forKey: "city") as? String
        state.text = trip?.object(forKey: "state") as? String
        zip.text = trip?.object(forKey: "zip") as? String
        address2.text = trip?.object(forKey: "address2") as? String
        city2.text = trip?.object(forKey: "city2") as? String
        state2.text = trip?.object(forKey: "state2") as? String
        zip2.text = trip?.object(forKey: "zip2") as? String
        
        let dateTest = trip?.object(forKey: "departure") as? Date
        departure.text = dateFormatter.string(from: dateTest!)
        
        carModel.text = trip?.object(forKey: "carModel") as? String
        carMake.text = trip?.object(forKey: "carMake") as? String
        license.text = trip?.object(forKey: "license") as? String
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func joinTripButton(_ sender: Any) {
    
        var riders = trip?.object(forKey: "riders") as? [String]
        
        var newSeats = trip?.object(forKey: "seatsAvailable") as? Int
        
        newSeats = newSeats! - 1
        
        let seatsValue = newSeats! as CKRecordValue
        
        trip?.setObject(seatsValue, forKey: "seatsAvailable")
        
        let joinEmail = joinTripEmail.text!
        riders?.append(joinEmail)
        
        let ridersValue = riders! as CKRecordValue
        
        trip?.setObject(ridersValue, forKey: "riders")
        
        let operation = CKModifyRecordsOperation(recordsToSave: [trip!], recordIDsToDelete: nil)
        
        publicDatabase.add(operation)
        
        let alert = UIAlertController(title: "Saved Successfully!", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(_) in
                self.navigationController?.popToRootViewController(animated: true)
        }))
        present(alert, animated: true, completion: nil)
      
        
        
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension TripViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

