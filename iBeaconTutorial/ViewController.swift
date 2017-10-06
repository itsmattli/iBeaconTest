//
//  ViewController.swift
//  iBeaconTutorial
//
//  Created by Matthew Li on 2017-10-05.
//  Copyright © 2017 Matthew Li. All rights reserved.
//
import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    var locationManager: CLLocationManager!
    
    
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var bText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.requestAlwaysAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if beacons.count > 0 {
            print(beacons)
            self.bText.text =  "UUID: \(beacons[0].proximityUUID). \nmajor: \(beacons[0].major)\nminor: \(beacons[0].minor) \nrssi: \(beacons[0].rssi) \naccuracy: \(beacons[0].accuracy) \n"
        } else {
            self.bText.text = "Beacon not found"
        }
    }
    
    func updateDistance(_ distance: CLProximity) {
        switch distance {
            case .unknown:
                self.bText.text = "Unknown"
                
            case .far:
                self.bText.text = "Far"
            
            case .near:
                self.bText.text = "Near"
                
            case .immediate:
                self.bText.text = "Immediate"
        }
     }

    func startScanning() {
        let uuid = UUID(uuidString: "C6C4C829-4FD9-4762-837C-DA24C665015A")!
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 1, minor: 319, identifier: "Kontakt Test")
        
        beaconRegion.notifyEntryStateOnDisplay = true
        beaconRegion.notifyOnEntry = true
        beaconRegion.notifyOnExit = true
        
        //locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
    }
}
