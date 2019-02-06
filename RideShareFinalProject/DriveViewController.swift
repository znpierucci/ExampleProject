//
//  DriveViewController.swift
//  RideShareFinalProject
//
//  Created by sahand sadri on 12/10/17.
//  Copyright © 2017 Sahand Sadri. All rights reserved.
//

import UIKit
import CloudKit
class DriveViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var departure: UITextField!
    @IBOutlet weak var time: UITextField!
    
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var zip: UITextField!
    
    @IBOutlet weak var address2: UITextField!
    @IBOutlet weak var city2: UITextField!
    @IBOutlet weak var state2: UITextField!
    @IBOutlet weak var zip2: UITextField!

    @IBOutlet weak var seatsAvailable: UITextField!
    
    @IBOutlet weak var carMake: UITextField!
    @IBOutlet weak var carModel: UITextField!
    @IBOutlet weak var carYear: UITextField!
    @IBOutlet weak var license: UITextField!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    
    
    
    
    //for date picker for depature
    let datePicker = UIDatePicker()
    
    func createDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(datePressed))
        
        toolbar.setItems([done], animated: false)
        departure.inputAccessoryView = toolbar
        departure.inputView = datePicker
        
        datePicker.datePickerMode = .date
    }
    
    @objc func datePressed(){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        departure.resignFirstResponder()
        
        let dateString = formatter.string(from: datePicker.date)
        
        departure.text = "\(dateString)"
        self.viewDidLoad()
    }
    
    
    //for date picker for time
    let timePicker = UIDatePicker()
    
    func createTimePicker(){
        let toolbar2 = UIToolbar()
        toolbar2.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(timePressed))
        
        toolbar2.setItems([done], animated: false)
        time.inputAccessoryView = toolbar2
        
        time.inputView = timePicker
        timePicker.datePickerMode = .time
    }
    
    @objc func timePressed(){
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .medium
        
        time.resignFirstResponder()
        
    
        let timeString = formatter.string(from: timePicker.date)
        
        
        time.text = "\(timeString)"
        self.viewDidLoad()
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        firstName.text = nil
        lastName.text = nil
        email.text = nil
        departure.text = nil
        time.text = nil
        address.text = nil
        city.text = nil
        state.text = nil
        zip.text = nil
        address2.text = nil
        city2.text = nil
        state2.text = nil
        zip2.text = nil
        seatsAvailable.text = nil
        carMake.text = nil
        carModel.text = nil
        carYear.text = nil
        license.text = nil
        
        print("Drive Records Cleared!")
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        if (firstName.text == "" || lastName.text == "" || email.text == "" || departure.text == "" || time.text == "" || address.text == "" || city.text == "" || state.text == "" || zip.text == "" || address2.text == "" || city2.text == "" || state2.text == "" || seatsAvailable.text == "" || carMake.text == "" || carModel.text == "" || carYear.text == "" || license.text == "")
        {
            
            let alert = UIAlertController(title: "Invalid Entry", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            present(alert, animated: true, completion: nil)
            
        } else {
            
        self.errorMessage.isHidden = true
        let trip = CKRecord(recordType: "Trip")
        var riders = [String]()
        riders.append(email.text!)
        trip.setValue(firstName.text!, forKey: "firstName")
        trip.setValue(lastName.text!, forKey: "lasName")
        trip.setValue(email.text!, forKey: "email")
        trip.setValue(riders, forKey: "riders")
        trip.setValue(timePicker.date, forKey: "departure")
        trip.setValue(timePicker.date, forKey: "time")
        
        trip.setValue(address.text!, forKey: "address")
        trip.setValue(city.text!, forKey: "city")
        trip.setValue(state.text!, forKey: "state")
        trip.setValue(zip.text!, forKey: "zip")
        
        trip.setValue(address2.text!, forKey: "address2")
        trip.setValue(city2.text!, forKey: "city2")
        trip.setValue(state2.text!, forKey: "state2")
        trip.setValue(zip2.text!, forKey: "zip2")
        
        let seatNumber = Int64(seatsAvailable.text!)
        trip.setValue(seatNumber, forKey: "seatsAvailable")
        
        trip.setValue(carMake.text!, forKey: "carMake")
        trip.setValue(carModel.text!, forKey: "carModel")
        
        let carYearInt = Int64(carYear.text!)
        trip.setValue(carYearInt, forKey: "carYear")
        trip.setValue(license.text!, forKey: "license")
        
        
        let publicDatabase = CKContainer(identifier: "iCloud.edu.mail.missouri.RideShareFinalProject").publicCloudDatabase
        publicDatabase.save(trip) {(record, error) in
            if error == nil{
                print("Record Saved MOTHERFUCKER")
                print(record!["firstName"] as! String)
                
            }else { print(error ?? print("default")) }
        }
        firstName.text = nil
        lastName.text = nil
        email.text = nil
        departure.text = nil
        time.text = nil
        address.text = nil
        city.text = nil
        state.text = nil
        zip.text = nil
        address2.text = nil
        city2.text = nil
        state2.text = nil
        zip2.text = nil
        seatsAvailable.text = nil
        carMake.text = nil
        carModel.text = nil
        carYear.text = nil
        license.text = nil
    
        }
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        firstName.delegate = self
        lastName.delegate = self
        
        email.delegate = self
        departure.delegate = self
        time.delegate = self
        
        address.delegate = self
        city.delegate = self
        state.delegate = self
        zip.delegate = self
        
        address2.delegate = self
        city2.delegate = self
        state2.delegate = self
        zip2.delegate = self
        
        seatsAvailable.delegate = self
        
        carMake.delegate = self
        carModel.delegate = self
        carYear.delegate = self
        license.delegate = self
        
        createDatePicker()
        createTimePicker()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
