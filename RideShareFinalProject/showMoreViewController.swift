//
//  showMoreViewController.swift
//  RideShareFinalProject
//
//  Created by Benjarit Hotrabhavananda on 12/14/17.
//  Copyright © 2017 Sahand Sadri. All rights reserved.
//

import UIKit
import CloudKit
class showMoreViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var tripInShowMore = [CKRecord](){
        didSet{
            if tableView != nil{
                tableView.reloadData()
            }
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripInShowMore.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = tripInShowMore[indexPath.row]
        let deque = tableView.dequeueReusableCell(withIdentifier: "myFirstCell", for: indexPath)
        if let cell = deque as? DashBoardTableViewCell{
            cell.infoToBeShown = data
        }
        return deque
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
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
