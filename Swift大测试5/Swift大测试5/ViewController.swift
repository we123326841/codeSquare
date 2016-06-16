//
//  ViewController.swift
//  Swift大测试5
//
//  Created by 王浩 on 16/4/11.
//  Copyright © 2016年 cc. All rights reserved.
//

import UIKit
import MapKit
class ViewController: UIViewController ,MKMapViewDelegate{
    var mapView:MKMapView?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapView = MKMapView(frame: CGRect(x: 10, y: 10, width: 300, height: 300))
        mapView?.delegate = self
        mapView?.centerCoordinate = CLLocationCoordinate2DMake(37.32, -122.03)
        mapView?.mapType = MKMapType.Hybrid
        var location:CLLocationCoordinate2D? = CLLocationCoordinate2D()
        location?.latitude = Double(37.332768)
        location?.longitude = Double(-122.030039)
        
       let newAnnotation = MapAnnotation(title: "苹果公园", coordinate: location!)
       mapView?.addAnnotation(newAnnotation)
        
        
        var location2:CLLocationCoordinate2D? = CLLocationCoordinate2D()
        location2?.latitude = Double(37.35239)
        location2?.longitude = Double(-122.025919)
       let newAnnotation2 = MapAnnotation(title: "你嘛嘛", coordinate: location2!)
        mapView?.addAnnotation(newAnnotation2)
        view.addSubview(mapView!)
    }
    
    func mapView(mapView: MKMapView, didAddAnnotationViews views: [MKAnnotationView]) {
       let annotationView = views[0]
       let mp = annotationView.annotation
      let region = MKCoordinateRegionMakeWithDistance((mp?.coordinate)!, 1500, 1500)
        mapView.setRegion(region, animated: true)
        mapView.selectAnnotation(mp!, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

