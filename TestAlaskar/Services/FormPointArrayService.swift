//
//  FormPointArrayService.swift
//  TestAlaskar
//
//  Created by Mariya on 17.11.16.
//  Copyright © 2016 Kilograpp. All rights reserved.
//

import Foundation
import GoogleMaps

fileprivate protocol FormArray {
    func configureRandomPoint(map: GMSMapView, userLocation: CLLocationCoordinate2D) -> Point
    func configureArray(map: GMSMapView, userLocation: CLLocationCoordinate2D) -> [Point]
}

final class FormPointArrayService {
    fileprivate let сoefficient = Double(111000) //примерное кол-во метров в одном градусе широты и долготы
    static let sharedInstance = FormPointArrayService()
}

extension FormPointArrayService: FormArray {
    func configureRandomPoint(map: GMSMapView, userLocation: CLLocationCoordinate2D)  -> Point {
        //формирование рандомных значений широты и долготы у точки в квадрате: +- 100 метров (на север, юг, запад, восток) от пользователя
        let latitudePoint = Double.random(lower: (userLocation.latitude - Constants.Radius.Standart/сoefficient),
                                                (userLocation.latitude + Constants.Radius.Standart/сoefficient))
        let longitudePoint = Double.random(lower: (userLocation.longitude - Constants.Radius.Standart/сoefficient),
                                                (userLocation.longitude + Constants.Radius.Standart/сoefficient))
        let point = Point()
        point.latitude = latitudePoint
        point.longitude = longitudePoint
        var pointCoordinate = CLLocationCoordinate2D()
        pointCoordinate.latitude = latitudePoint
        pointCoordinate.longitude = longitudePoint
        point.distance = GMSGeometryDistance(userLocation, pointCoordinate)
        return point
    }
    
    func configureArray(map: GMSMapView, userLocation: CLLocationCoordinate2D) -> [Point]{
        var arrayPoint: [Point] = []

        while arrayPoint.count < Constants.Count.RandomPoint {
            let point = configureRandomPoint(map: map, userLocation: userLocation)
            if point.distance <= Constants.Radius.Standart {
                arrayPoint.append(point)
            }
        }
        return arrayPoint
    }
}
