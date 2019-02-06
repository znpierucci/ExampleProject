//
//  TripInformationViewController.swift
//  RideShareFinalProject
//
//  Created by Benjarit Hotrabhavananda on 12/8/17.
//  Copyright © 2017 Sahand Sadri. All rights reserved.
//

import UIKit
import CloudKit
class TripInformationViewController: UIViewController {
    
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var start: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var destination: UILabel!
    @IBOutlet weak var departure: UILabel!
    @IBOutlet weak var carModel: UILabel!
    
    //var trip = driverTrip()
    var tripModel: CKRecord?{
        didSet{
            updateUI()
        }
    }
    
    private func updateUI(){
        if email != nil{
            let firstName = (tripModel?["firstName"] as! String)
            let full = firstName + (tripModel?["lasName"] as! String)
            fullName.text = full
            email.text = (tripModel?["email"] as! String)
            start.text = (tripModel?["address"] as! String)
            destination.text = (tripModel?["address2"] as! String)
            let departureTime = (tripModel?["departure"] as! Date)
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.dateStyle = .short
            departure.text = formatter.string(from: departureTime)
            carModel.text = (tripModel?["carModel"] as! String)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
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
    
}

