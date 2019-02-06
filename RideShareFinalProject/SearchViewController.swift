//
//  SearchViewController.swift
//  RideShareFinalProject
//
//  Created by sahand sadri on 12/9/17.
//  Copyright © 2017 Sahand Sadri. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBAction func search(_ sender: UIButton) {
        
        performSegue(withIdentifier: "search", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destVC = segue.destination as! ResultsViewController
        
        destVC.city1 = city1.text!
        destVC.city2 = city2.text!
        
        
    }
    
    
    
    
    
    @IBOutlet weak var dateField: UITextField!
    
    let picker = UIDatePicker()
    
    @IBOutlet weak var city1: UITextField!
    @IBOutlet weak var city2: UITextField!
    
    
    func createDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(datePressed))
        
        toolbar.setItems([done], animated: false)
        dateField.inputAccessoryView = toolbar
        dateField.inputView = picker
        
        picker.datePickerMode = .date
    }
    
    @objc func datePressed(){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        let dateString = formatter.string(from: picker.date)
        
        dateField.text = "\(dateString)"
        self.view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        createDatePicker()
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
    
}

