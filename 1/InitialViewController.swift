//
//  InitialViewController.swift
//  Court Fee
//
//  Created by Anna on 18.07.17.
//  Copyright © 2017 Anna. All rights reserved.
//

import UIKit
import GoogleMobileAds
import FirebaseDatabase

class InitialViewController: UIViewController, GADBannerViewDelegate {
    
    @IBOutlet weak var myBanner: GADBannerView!
    
    var ref: DatabaseReference?
    var exeptionArray = [String]()
    var exeptionArrayCount = Int()
    var courtsCount = Int()
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        
        myBanner.adUnitID = "ca-app-pub-4375494746414239/6254715307"
        myBanner.rootViewController = self
        myBanner.delegate = self
        myBanner.load(request)
        ref = Database.database().reference()

        
        self.ref?.child("exeptionArrayCount").observe(.value, with: { (snapshot) in
            if let value = snapshot.value as? Int {
                self.exeptionArrayCount = value
            }
        })
        self.ref?.child("courtsCount").observe(.value, with: { (snapshot) in
            if let value = snapshot.value as? Int {
                self.courtsCount = value
            }
        })
        
        self.ref?.child("exeptionArray").observe(.value, with: { (snapshot) in
            print("SNAPSHOT: \(snapshot.value)")
            if let value = snapshot.value as? NSArray {
                
                self.exeptionArray = value as! [String] 
//                for i in 0..<self.exeptionArrayCount {
//                    let string = String(i)
//                    self.exeptionArray.append(value[string] as! String)
//                }
                
            }
        })

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        let destViewController = segue.destination as! PaymentDetailsViewController

        destViewController.exeptionArrayCount = self.exeptionArrayCount
        destViewController.courtsCount = self.courtsCount
        destViewController.exeptionArray = self.exeptionArray
        print("EXEPTIONCOUNT: \(exeptionArrayCount)")
        print("COURTSCOUNT: \(courtsCount)")
        print("EXEPTION: \(exeptionArray.count)")
    }

    
}