//
//  ViewController.swift
//  Судовий збір. Реквізити
//
//  Created by Anna on 12.05.17.
//  Copyright © 2017 Anna. All rights reserved.
//

import UIKit
import FirebaseDatabase
import GoogleMobileAds

class PaymentDetailsViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, GADBannerViewDelegate {
    
    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var output: UILabel!
    @IBOutlet weak var dropDown: UITableView!

    @IBOutlet weak var dropDownHeight: NSLayoutConstraint!
    @IBOutlet weak var myBanner: GADBannerView!
    @IBOutlet weak var bannerWidth: NSLayoutConstraint!
    @IBOutlet weak var bannerHeight: NSLayoutConstraint!
    
    
    var ref: DatabaseReference? = Database.database().reference()
    var fullInformationArray = [[String : AnyObject]]()
    var dropDownArray = [String]()
    var exeptionArray = [String]()
    var exeptionArrayCount = Int()
    var courtsCount = Int()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        text.delegate = self
        dropDown.isHidden = true
        dropDown.rowHeight = 20
//        self.navigationController?.navigationBar.topItem!.title = "Назад"
//        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = false

        // get data from Firebase
        self.ref?.child("courts").observe(.value, with: { (snapshot) in
                        if let value = snapshot.value as? [[String : AnyObject]] {
                            self.fullInformationArray = value
            }
        })

        // ad banner
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        myBanner.adUnitID = banner5
        myBanner.rootViewController = self
        myBanner.delegate = self
        myBanner.load(request)
        
        if UIDevice.current.model == "iPad" {
            bannerWidth.constant = 728
            bannerHeight.constant = 90
        }

   }
    
    //key board will dissmiss while touching screeng anywhere
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        performAction()
        return true
    }
    
    func performAction () -> () {
        for i in fullInformationArray {
            let name = i["crt_name"] as! String
            let lowName = name.lowercased()
            let input = text.text?.lowercased()
            var match = 0
            for x in exeptionArray {
                if x.lowercased() == input {
                    match = 1
                }
            }
            if match == 1 {
                output.text = "Даний суд знаходиться в районі проведення антитерористичної операції і не може здійснювати правосуддя. Згідно Закону України 'Про здійснення правосуддя та кримінального провадження у зв’язку з проведенням антитерористичної операції' справи, підсудні даному суду, розглядаються судами, що визначаються головою Вищого спеціалізованого суду України з розгляду цивільних і кримінальних справ"
                break
            } else {
                if input?.lowercased() == lowName {
                    output.text = "Платiжнi реквiзити для перерахування судового збору в гривнях\n\n\(name)\n\nОтримувач коштів:  \(i["tax_payee"]!) \nКод отримувача (код за ЄДРПОУ):  \(i["tax_zkpo"]!)\nБанк отримувача:  \(i["tax_bank"])\nКод банку отримувача (МФО):  \(i["tax_mfo"]!)\nРахунок отримувача:  \(i["tax_account"]!)\nКод класифікації доходів бюджету:  \(i["tax_code"]!)\nПризначення платежу: *;101;__________(ІПН/ЄДРПОУ платника);Судовий збір, за позовом ___________ (ПІБ/назва), \(name)"
                }
            }
        }
    }


    @IBAction func searchButton(_ sender: UIButton) {
        performAction()
    }
    
    @IBAction func ifTextHasChanged(_ sender: Any) {
        if (text.text?.characters.count)! >= 3 {
            dropDown.isHidden = false
            dropDownArray = []
            for i in fullInformationArray {
                let name = i["crt_name"] as! String
                let lowName = name.lowercased()
                let input = text.text?.lowercased()
                if input?.lowercased() == lowName || (lowName.range(of: input!) != nil) {
                    dropDownArray.append(name)
                    self.dropDown.reloadData()
                }
            }
            dropDownHeight.constant = dropDown.contentSize.height
            
        } else {
            dropDownArray = []
            dropDown.isHidden = true
        }
    }
    
    
    // MARK: DROPDOWN MENU
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropDownArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownCell", for: indexPath)
        cell.textLabel?.text = dropDownArray[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        text.text = tableView.cellForRow(at: indexPath)?.textLabel?.text
        dropDown.isHidden = true
        performAction()
    }
        

    
}

