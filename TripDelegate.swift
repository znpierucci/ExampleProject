//
//  TripDelegate.swift
//  RideShareFinalProject
//
//  Created by sahand sadri on 12/13/17.
//  Copyright © 2017 Sahand Sadri. All rights reserved.
//

import Foundation
import CloudKit

protocol TripDelegate: class {
    func add(trips: [CKRecord])
}

