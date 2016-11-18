//
//  GMSMarker+Icon.swift
//  TestAlaskar
//
//  Created by Mariya on 18.11.16.
//  Copyright © 2016 Kilograpp. All rights reserved.
//

import Foundation
import GoogleMaps

extension GMSMarker {
    public static func markerImage(for myLocation:CLLocationCoordinate2D?, targetLocation:CLLocationCoordinate2D) -> UIImage {
        guard myLocation != nil else { return GMSMarker.markerImage(with: UIColor.yellow) }
        let distance = GMSGeometryDistance(myLocation!, targetLocation)
        return GMSMarker.markerImage(with: distance <= Constants.Radius.Min ? UIColor.green : UIColor.yellow)
    }
}
