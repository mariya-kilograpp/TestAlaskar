//
//  Double+Random.swift
//  TestAlaskar
//
//  Created by Mariya on 17.11.16.
//  Copyright © 2016 Kilograpp. All rights reserved.
//
import Foundation

public extension Double {
    public static func random(lower: Double = 0, _ upper: Double = 100) -> Double {
        return (Double(arc4random()) / 0xFFFFFFFF) * (upper - lower) + lower
    }
}
