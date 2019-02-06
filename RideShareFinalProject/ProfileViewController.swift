//
//  ProfileViewController.swift
//  RideShareFinalProject
//
//  Created by Kevin Hunkins on 12/12/17.
//  Copyright © 2017 Sahand Sadri. All rights reserved.
//

import UIKit
import CloudKit

class ProfileViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        profileFirstName.delegate = self
        profileLastName.delegate = self
        profileEmail.delegate = self
        profileSchool.delegate = self
        profileMajor.delegate = self
        profileClass.delegate = self
        profileBirthday.delegate = self
        profileBio.delegate = self
        
        self.profileImage.image = UIImage(named: "Profile_Selected")
        
        createDatePicker()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var profileFirstName: UITextField!
    @IBOutlet weak var profileLastName: UITextField!
    @IBOutlet weak var profileEmail: UITextField!
    @IBOutlet weak var profileSchool: UITextField!
    @IBOutlet weak var profileMajor: UITextField!
    @IBOutlet weak var profileClass: UITextField!
    @IBOutlet weak var profileBirthday: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileBio: UITextView!
    @IBOutlet weak var errorMessage: UILabel!
    

    @IBAction func profileGender(_ sender: UISegmentedControl) {
    }
    
    let datePicker = UIDatePicker()
    
    func createDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(datePressed))
        
        toolbar.setItems([done], animated: false)
        profileBirthday.inputAccessoryView = toolbar
        profileBirthday.inputView = datePicker
        
        datePicker.datePickerMode = .date
    }
    
    @objc func datePressed(){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        profileBirthday.resignFirstResponder()
        
        let dateString = formatter.string(from: datePicker.date)
        
        profileBirthday.text = "\(dateString)"
        self.viewDidLoad()
        
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        if (profileFirstName.text == "" || profileLastName.text == "" || profileEmail.text == "" || profileSchool.text == "" || profileMajor.text == "" || profileClass.text == "" || profileBirthday.text == "" || profileBio.text == "")
        {
//            self.errorMessage.textColor = UIColor.red
//            self.errorMessage.text = "Invalid Entry"
//            self.errorMessage.isHidden = false
            let alert = UIAlertController(title: "Invalid Entry", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            present(alert, animated: true, completion: nil)
            
            
        } else {
        
        //self.errorMessage.isHidden = true
        print("Save button clicked")
            let alert = UIAlertController(title: "Saved Successfully!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            present(alert, animated: true, completion: nil)
        let profile = CKRecord(recordType: "Profile")
        profile.setValue(profileFirstName.text!, forKey: "profileFirstName")
        profile.setValue(profileLastName.text!, forKey: "profileLastName")
        profile.setValue(profileEmail.text!, forKey: "profileEmail")
        profile.setValue(profileBirthday.text!, forKey: "profileBirthday")
        profile.setValue(profileSchool.text!, forKey: "profileSchool")
        profile.setValue(profileMajor.text!, forKey: "profileMajor")
        profile.setValue(profileClass.text!, forKey: "profileClass")
        
        let publicDatabase = CKContainer(identifier: "iCloud.edu.mail.missouri.RideShareFinalProject").publicCloudDatabase
        publicDatabase.save(profile) {(record, error) in
            if error == nil{
                print("Record Saved")
                print(record!["profileFirstName"] as! String)
            }
        }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

}
