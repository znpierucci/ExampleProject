//
//  User.swift
//  RideShareFinalProject
//
//  Created by sahand sadri on 11/9/17.
//  Copyright © 2017 Sahand Sadri. All rights reserved.
//

import Foundation
import UIKit

class User{
    
    //    This is the account information for both the rider and driver
    
    var firstName: String
    var middleName: String
    var lastName: String
    
    var dob: Date
    var gender: Gender
    var email: String
    var major: String
    var classRank: String
    var photo: UIImage
    var studentDescription: String
    var userVehicle: Vehicle
    
    static var numberOfRatingForPassenger: Double = 0.0
    var passengerStar: Double = 0.0{
        didSet{
            User.numberOfRatingForPassenger = User.numberOfRatingForPassenger + 1
            passengerStar = (oldValue + passengerStar)/User.numberOfRatingForPassenger
        }
    }
    
    static var numberOfRatingForDriver: Double = 0.0
    var driverStar: Double = 0.0{
        didSet{
            User.numberOfRatingForDriver = User.numberOfRatingForDriver + 1
            driverStar = (oldValue + driverStar)/User.numberOfRatingForDriver
        }
    }
    
    
    init(firstName: String, middleName: String, lastName: String, dob: Date, gender: Gender, email: String,
         major: String, classRank: String, photo: UIImage, studentDescription: String, userVehicle: Vehicle, passengerRating: Double, driverRating: Double){
        
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
        self.dob = dob
        self.gender = gender
        self.email = email
        self.major = major
        self.classRank = classRank
        self.photo = photo
        self.studentDescription = studentDescription
        self.userVehicle = userVehicle
        //self.totalPassRating = totalPassRating
        //self.totalDriverRating = totalDriverRating
    }
    enum Gender{
        case MALE
        case FEMALE
        case OTHER
    }
    
    struct Vehicle{
        //    Information about the user's vehicle that can be added to a user's account
        var make: String
        var model: String
        var year: Int
        var seating: Int
        var cargoSpace: Cargo
    }
    
    enum Cargo{
        case SMALL
        case MEDIUM
        case LARGE
    }
}
