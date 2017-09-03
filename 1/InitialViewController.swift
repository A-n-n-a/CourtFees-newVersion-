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

let banner1 = "ca-app-pub-4375494746414239/6254715307"
let banner2 = "ca-app-pub-4375494746414239/1425891577"
let banner3 = "ca-app-pub-4375494746414239/2519481392"
let banner4 = "ca-app-pub-4375494746414239/6075583020"
let banner5 = "ca-app-pub-4375494746414239/7005521312"

class InitialViewController: UIViewController, GADBannerViewDelegate {
    
    @IBOutlet weak var myBanner: GADBannerView!
    @IBOutlet weak var bannerWidth: NSLayoutConstraint!
    @IBOutlet weak var bannerHeight: NSLayoutConstraint!
    
    var ref: DatabaseReference?
    var exeptionArray = [String]()
    var exeptionArrayCount = Int()
    var courtsCount = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem!.title = "Назад"
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        // ad banner
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        myBanner.adUnitID = banner1
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
            if let value = snapshot.value as? NSArray {
                self.exeptionArray = value as! [String]
            }
        })
        
        if UIDevice.current.model == "iPad" {
            bannerWidth.constant = 728
            bannerHeight.constant = 90
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ToPaymentDetails" {
        
            let destViewController = segue.destination as! PaymentDetailsViewController
            destViewController.exeptionArrayCount = self.exeptionArrayCount
            destViewController.courtsCount = self.courtsCount
            destViewController.exeptionArray = self.exeptionArray
            print("EXEPTIONCOUNT: \(exeptionArrayCount)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
}
