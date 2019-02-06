//
//  Trip.swift
//  RideShareFinalProject
//
//  Created by sahand sadri on 11/9/17.
//  Copyright © 2017 Sahand Sadri. All rights reserved.
//

import Foundation


enum Location{
    case SaintLouis
    case Chicago
    case KansasCity
    case Columbia
}


struct driverTrip{
    //    Trip created by drivers, riders can request to join as passengers
    
    var locationFrom: Location
    var destination: Location
    var DepartureTime: Date
    var seatsAvailable: Int64
    
//    var startDate: Date
//    var returnDate: Date
//    var returnTime: Date
//    var price: Int
//    var comments: String
//    //var comments: String
    
}
