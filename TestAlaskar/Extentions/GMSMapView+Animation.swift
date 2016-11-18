//
//  GMSMapView+Animation.swift
//  TestAlaskar
//
//  Created by Mariya on 17.11.16.
//  Copyright © 2016 Kilograpp. All rights reserved.
//

import Foundation
import GoogleMaps

extension GMSMapView {
    func animateToLocation(_ location: CLLocationCoordinate2D, slowly: Bool, completion: @escaping () -> Void) {
        var popTime = DispatchTime.now()
        if slowly {
            let timeDelay: Int64  = 1
            popTime = popTime + Double(timeDelay * Int64(NSEC_PER_SEC)) / Double(NSEC_PER_SEC)
        }
        DispatchQueue.main.asyncAfter(deadline: popTime) {
            CATransaction.begin()
            let duration = slowly == true ? Constants.Common.SlowAnimateDuration : Constants.Common.FastAnimateDuration
            CATransaction.setValue(duration, forKey: kCATransactionAnimationDuration)
            let cameraPosition = GMSCameraPosition.camera(withTarget: location, zoom: Float(Constants.Zoom.Standart))
            self.animate(to: cameraPosition)
            CATransaction.commit()
            
            let timeDelay: Int64  = 2
            DispatchQueue.main.asyncAfter(wallDeadline: DispatchWallTime.now() + Double(timeDelay * Int64(NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: {
                completion()
            })
        }
        
        
    }
}
