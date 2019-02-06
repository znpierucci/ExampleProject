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
            let full = firstName + " " +  (tripModel?["lasName"] as! String)
            fullName.text = full
            email.text = (tripModel?["email"] as! String)
            let adress = (tripModel?["address"] as! String)
            let city = (tripModel?["city"] as! String)
            let state = (tripModel?["state"] as! String)
            let zip = (tripModel?["zip"] as! String)
            let fullAddress = adress + " " + city + ", " + state + " " + zip
            start.text = fullAddress
            
            let adress2 = (tripModel?["address2"] as! String)
            let city2 = (tripModel?["city2"] as! String)
            let state2 = (tripModel?["state2"] as! String)
            let zip2 = (tripModel?["zip2"] as! String)
            let fullAddress2 = adress2 + " " + city2 + ", " + state2 + " " + zip2
            destination.text = fullAddress2
            
            
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .none
            let departureTime = formatter.string(from:(tripModel?["departure"] as! Date))
            

            formatter.dateStyle = .none
            formatter.timeStyle = .short
            let time = formatter.string(from:(tripModel?["time"] as! Date))

            let fullTime = departureTime + "\t" + time
            departure.text = fullTime
            
            let car = (tripModel?["carModel"] as! String)
            let carMake = (tripModel?["carMake"] as! String)
            let carLicense = (tripModel?["license"] as! String)
            let carYear = (tripModel?["carYear"] as! Int64)
            
            let carFull = carMake + " " + car + " " + String(carYear) + " \nLicense: " + carLicense
                
            carModel.text = carFull
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


