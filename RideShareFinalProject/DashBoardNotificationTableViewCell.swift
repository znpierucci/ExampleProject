//
//  DashBoardNotificationTableViewCell.swift
//  RideShareFinalProject
//
//  Created by Benjarit Hotrabhavananda on 12/6/17.
//  Copyright © 2017 Sahand Sadri. All rights reserved.
//

import UIKit
import CloudKit
class DashBoardNotificationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var information: UILabel!
    @IBOutlet weak var dateOfNotication: UILabel!    
    var infoToBeShown: String?{
        didSet{
            updateUI()
        }
    }
    private func updateUI(){
        profileImage.image = UIImage(named: "printable-letter-j-silhouette-1.png")
        
        // Set circular image view
        profileImage.layer.cornerRadius = self.profileImage.frame.width / 2
        profileImage.clipsToBounds = true
        
        // Set request description and date
//        let firstName = (infoToBeShown?["firstName"] as! String)
//        let lastName = (infoToBeShown?["lastName"] as! String)
//        let depart = (infoToBeShown?["departure"] as! String)
//        let city = (infoToBeShown?["city2"] as! String)
//
//        let full = firstName + " " + lastName + "requested to join your " + depart + " trip to " + city + "."
//
        information.text = "Justin James requestd to join your 11/5 trip to Chicago"
        dateOfNotication.text = "Yesterday"
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
