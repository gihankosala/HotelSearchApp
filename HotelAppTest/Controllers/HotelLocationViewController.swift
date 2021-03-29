//
//  HotelLocationViewController.swift
//  HotelAppTest
//
//  Created by Admin on 3/29/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import UIKit
import GoogleMaps


class HotelLocationViewController: UIViewController  {

    var selectedResponce:Datum?
    @IBOutlet weak var viewForMap: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setupLocation()
        
    }
    
    func setUpNavigationBar(){
         
         //navigation bar
         //let backButton = UIBarButtonItem(image: UIImage(named: "back icn"), style: .plain, target: self, action: #selector(backButtonAction(_:)))
         //self.navigationItem.leftBarButtonItem = backButton
         self.navigationItem.leftBarButtonItem?.tintColor = UIColor.green
         self.navigationItem.title = "Map View"
         
     }
    
    func setupLocation() {
        
        let lat:Double = Double((selectedResponce?.latitude)!)!
        let long:Double = Double((selectedResponce?.longitude)!)!
        
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.viewForMap.addSubview(mapView)
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
        marker.title = selectedResponce!.title
        marker.snippet = selectedResponce!.address
        marker.map = mapView
        mapView.selectedMarker = marker
        
    }
    
    
    

   

}
