//
//  ResultsViewController.swift
//  RideShareFinalProject
//
//  Created by sahand sadri on 12/13/17.
//  Copyright © 2017 Sahand Sadri. All rights reserved.
//

import UIKit
import CloudKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var trip2TableView: UITableView!
    
    var city2 = ""
    var city1 = ""
    
    let publicDatabase = CKContainer(identifier: "iCloud.edu.mail.missouri.RideShareFinalProject").publicCloudDatabase
    
    var trips = [CKRecord]()
    
    
//    let predicate = NSPredicate(format: "city2 = %@ AND city = %@", city2, city1)

    func queryTrips(){
        let predicate = NSPredicate(format: "city2 = %@ AND city = %@ AND seatsAvailable > 0", city2, city1)
        let query = CKQuery(recordType: "Trip", predicate: predicate)
        
        publicDatabase.perform(query, inZoneWith: nil) {
            (trips, error) in
            DispatchQueue.main.async {
                if let error = error{
                    print(error)
                } else {
                    self.trips = trips ?? []
                    
                    self.trip2TableView.reloadData()
                }
            }
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        guard let destination = segue.destination as? TripViewController else{
            return
        }
        
        destination.tripDelegate = self
        
        if let selectedRow = trip2TableView.indexPathForSelectedRow?.row{
            destination.trip = trips[selectedRow]
        }
        
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

       
        queryTrips()
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


extension ResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = trip2TableView.dequeueReusableCell(withIdentifier: "tripCell", for: indexPath)
        
        let trip = trips[indexPath.row]
        
        cell.textLabel?.text = trip.object(forKey: "firstName") as? String
        
        let text = (trip.object(forKey: "city") as? String ?? "") + "\t -> " + (trip.object(forKey: "city2") as? String ?? "")
        
        cell.detailTextLabel?.text = text
        
        return cell
    }
}

extension ResultsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showTrip2", sender: self)
    }
}

extension ResultsViewController: TripDelegate {
    func add(trips: [CKRecord]) {
        self.trips.append(contentsOf: trips)
        
        self.trip2TableView?.reloadData()
    }
}


