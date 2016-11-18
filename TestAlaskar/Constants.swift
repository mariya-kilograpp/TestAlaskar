//
//  Constants.swift
//  TestAlaskar
//
//  Created by Mariya on 17.11.16.
//  Copyright © 2016 Kilograpp. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Api {
        static let ApiGoogleKey = "AIzaSyA6IdYoRPJmcszEa9VMqhJcuMYN8lCAE2A"
    }
    
    struct Common {
        static let SlowAnimateDuration = 1.5
        static let FastAnimateDuration = 0.3
    }
    
    struct CoordinateMoscow {
        static let Latitude = 55.7490868
        static let Longitude = 37.6307583
    }
    
    struct Zoom {
        static let First = 9
        static let Standart = 17
    }
    
    struct Radius {
        static let Standart = Double(100)
        static let Min = Double(20)
    }
    
    struct Count {
        static let RandomPoint = 10
    }
}
