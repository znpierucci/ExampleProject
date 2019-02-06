//
//  DashBoardViewController.swift
//  RideShareFinalProject
//
//  Created by Benjarit Hotrabhavananda on 12/6/17.
//  Copyright © 2017 Sahand Sadri. All rights reserved.
//

import UIKit
import CloudKit

class DashBoardViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var trip = [CKRecord]()
    
    var email = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: #selector(self.retieveData), for: UIControlEvents.valueChanged)
        self.tableView.refreshControl = refresher
        retieveData(isCreated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            if trip.count < 4 && trip.count >= 0{
                return trip.count
            }else{
                return 4
            }
        }
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var deque: UITableViewCell
        if indexPath.section == 0{
            if indexPath.row == 3{
                deque = tableView.dequeueReusableCell(withIdentifier: "showMoreCell", for: indexPath)
            }else{
                let data = trip[indexPath.row]
                deque = tableView.dequeueReusableCell(withIdentifier: "myFirstCell", for: indexPath)
                if let cell = deque as? DashBoardTableViewCell{
                    cell.infoToBeShown = data
                }
            }
        }else{
            deque = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath)
            if let cell = deque as? DashBoardNotificationTableViewCell{
                cell.infoToBeShown = "Data setted"
            }
        }
        return deque
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Upcoming trips"
        }else{
            return "Notifications"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // "Show more" row to be 30 px high
        if indexPath.section == 0{
            if indexPath.row == 3{
                return 30
            }
        }
        return 70
    }
    // Swipe functionality
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("OK, you have delete the request.")
            success(true)
        })
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let confirmAction = UIContextualAction(style: .normal, title:  "Confirm", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("OK, you have confirmed the request.")
            success(true)
        })
        confirmAction.backgroundColor = UIColor(red: 0.298, green: 0.851, blue: 0.3922, alpha: 1.0)
        return UISwipeActionsConfiguration(actions: [confirmAction])
    }
    
    // Switching between views
    @IBAction func viewPastActionsToggle(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            retieveData(isCreated: true)
        }else if sender.selectedSegmentIndex == 1{
            retieveData(isCreated: false)
        }
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier{
            switch identifier{
            case "showMoreUpComingEvents":
                if let segueMCV = segue.destination as? showMoreViewController {
                    segueMCV.tripInShowMore = trip
                }
                break
            case "showTripInfomation":
                if let cell = sender as? DashBoardTableViewCell{
                    if let indexPath = tableView.indexPath(for: cell){
                        if let segueMCV = segue.destination as? TripInformationViewController {
                            let data = trip[indexPath.row]
                            segueMCV.tripModel = data
                        }
                    }
                }
                break
            default:
                break
            }
        }
    }
    @objc func retieveData(isCreated: Bool){
        CKContainer(identifier: "iCloud.edu.mail.missouri.RideShareFinalProject").fetchUserRecordID { (userRecordID, error) in
            //let predicate: NSPredicate
            let predicate: NSPredicate
            if isCreated == true{
                predicate = NSPredicate(format: "creatorUserRecordID = %@", userRecordID!)
            }else{
                print(self.email)
                predicate = NSPredicate(format: "riders CONTAINS %@", self.email)
            }
            let query = CKQuery(recordType: "Trip", predicate: predicate)
            let db = CKContainer(identifier: "iCloud.edu.mail.missouri.RideShareFinalProject").publicCloudDatabase
            db.perform(query, inZoneWith: nil) { (records, error) in
                if error == nil{
                    guard let records = records else{ return }
                    self.trip = records
                    DispatchQueue.main.async{
                        self.tableView.reloadData()
                        self.tableView.refreshControl?.endRefreshing()
                    }
                }
            }
        }
    }
}
