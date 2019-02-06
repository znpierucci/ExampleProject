//
//  DashBoardTableViewCell.swift
//  RideShareFinalProject
//
//  Created by Benjarit Hotrabhavananda on 12/5/17.
//  Copyright © 2017 Sahand Sadri. All rights reserved.
//

import UIKit
import CloudKit

class DashBoardTableViewCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var departureTime: UILabel!
    @IBOutlet weak var start: UILabel!
    @IBOutlet weak var arrow: UIImageView!
    @IBOutlet weak var desination: UILabel!
    
    // public API
    var infoToBeShown: CKRecord?{
        didSet{
            updateUI()
        }
    }
    private func updateUI(){
            start.text = (infoToBeShown?["city"] as! String)
            desination.text = (infoToBeShown?["city2"] as! String)
            let depart = (infoToBeShown?["departure"] as! Date)
            let time = (infoToBeShown?["time"] as! Date)
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .none
            date.text = formatter.string(from: depart)
            formatter.dateStyle = .none
            formatter.timeStyle = .short
            departureTime.text = formatter.string(from: time)
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
