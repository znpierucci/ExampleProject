//
//  LoginViewController.swift
//  RideShareFinalProject
//
//  Created by sahand sadri on 12/13/17.
//  Copyright © 2017 Sahand Sadri. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var login: UIButton!
   
    @IBAction func login(_ sender: Any) {
        if (loginTextField.text == "")
        {
            self.errorMessage.textColor = UIColor.red
            self.errorMessage.text = "Invalid Email!"
            self.errorMessage.isHidden = false
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destVC = segue.destination as? DashBoardViewController{
            destVC.email = loginTextField.text!
        }
    }
}
