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
    @IBOutlet weak var beaconProx: UILabel!
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
            updateDistance(beacons[0].proximity)
        } else {
            NSLog("Beacon not found")
        }
    }
    
    func updateDistance(_ distance: CLProximity) {
        switch distance {
            case .unknown:
                self.beaconProx.text = "Unknown"
                
            case .far:
                self.beaconProx.text = "Far"
            
            case .near:
                self.beaconProx.text = "Near"
                
            case .immediate:
                self.beaconProx.text = "Immediate"
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
