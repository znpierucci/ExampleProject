//
//  RideViewController.swift
//  RideShareFinalProject
//
//  Created by sahand sadri on 12/12/17.
//  Copyright © 2017 Sahand Sadri. All rights reserved.
//

import UIKit
import CloudKit

class RideViewController: UIViewController {
    
    @IBOutlet weak var tripsTableView: UITableView!
    var refresher = UIRefreshControl()
    
    let publicDatabase = CKContainer(identifier: "iCloud.edu.mail.missouri.RideShareFinalProject").publicCloudDatabase
    
    var trips = [CKRecord]()
    
    
    @objc func queryTrips(){
        let predicate = NSPredicate(format: "seatsAvailable > 0")
        
        let query = CKQuery(recordType: "Trip", predicate: predicate)
        
        publicDatabase.perform(query, inZoneWith: nil) { (trips, error) in DispatchQueue.main.async {
            if let error = error {
                print(error)
            } else {
                
                print("we got this far")
                //print(trips?.count)
                
                self.trips = trips ?? []
                
                self.tripsTableView.reloadData()
                self.refresher.endRefreshing()
            }
            }
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        guard let destination = segue.destination as? TripViewController else{
            return
        }
        destination.tripDelegate = self
        
        if let selectedRow = tripsTableView.indexPathForSelectedRow?.row{
            destination.trip = trips[selectedRow]
        }
        
    }
    
    
    /*
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return self.trips.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tripsTableView.dequeueReusableCell(withIdentifier: "tripCell", for: indexPath)
     
     let trip = trips[indexPath.row]
     
     cell.textLabel?.text = trip.object(forKey: "firstName") as? String
     
     
     
     
     return cell
     }
     */
    /*  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     performSegue(withIdentifier: "showExpense", sender: self)
     }
     */
    //
    //    override func viewWillAppear(_ animated: Bool) {
    //        queryTrips()
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        queryTrips()
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: #selector(RideViewController.queryTrips), for: UIControlEvents.valueChanged)
        tripsTableView.addSubview(refresher)
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

extension RideViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tripsTableView.dequeueReusableCell(withIdentifier: "tripCell", for: indexPath)
        
        let trip = trips[indexPath.row]
        
        cell.textLabel?.text = trip.object(forKey: "firstName") as? String
        
        let text = (trip.object(forKey: "city") as? String ?? "") + "\t -> " + (trip.object(forKey: "city2") as? String ?? "")
        
        cell.detailTextLabel?.text = text

        return cell
    }
}

extension RideViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showTrip", sender: self)
    }
}

extension RideViewController: TripDelegate {
    func add(trips: [CKRecord]) {
        self.trips.append(contentsOf: trips)
        
        self.tripsTableView?.reloadData()
    }
}


