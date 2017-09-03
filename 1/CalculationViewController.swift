

import UIKit
import Firebase
import FirebaseDatabase
import GoogleMobileAds



class CalculationViewController: UIViewController, UITextFieldDelegate, GADBannerViewDelegate {
    
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var sheetsLabel: UILabel!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var sheetsTextField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var myBanner: GADBannerView!
    @IBOutlet weak var bannerWidth: NSLayoutConstraint!
    @IBOutlet weak var bannerHeight: NSLayoutConstraint!
    
    //@IBOutlet weak var alignVertically: NSLayoutConstraint!
    @IBOutlet weak var bannerBottomConstraint: NSLayoutConstraint!
   
    var socialMinimum = Float() //= 1600.00
    
    var percent = Float()
    var min = Float()
    var max = Float()
    var percentOfFirstInstanceFee = Float()
    
    var minimum = Float()
    var maximum = Float()
    var fee = Float()
    var claimPrice = Float()
    
    var sheetsNeeded = Bool()
    
    
    
    let dispatchGroup = DispatchGroup()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem!.title = "Назад"
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        if UIDevice.current.model == "iPad" {
            bannerWidth.constant = 728
            bannerHeight.constant = 90
        }
        
        priceTextField.delegate = self
        sheetsTextField.delegate = self

        // ad banner
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        myBanner.adUnitID = banner4
        myBanner.rootViewController = self
        myBanner.delegate = self
        myBanner.load(request)
        
        if percentOfFirstInstanceFee != 0 {
            inputLabel.text = "Введіть розмір ставки судового збору, що підлягала сплаті при поданні позовної заяви, іншої заяви і скарги"
            
        } else {
            if percent != 0 {
                inputLabel.text = "Введіть ціну позову"
            } else {
                inputLabel.text = ""
                priceTextField.isHidden = true
            }
        }
        
        if sheetsNeeded == false {
            sheetsLabel.isHidden = true
            sheetsTextField.isHidden = true
            button.isHidden = true
            fee = socialMinimum * min
            outputLabel.text = "Сума судового збору:\n\(fee) грн."
            bannerBottomConstraint.constant = self.view.frame.height / 2 - bannerHeight.constant
        }   
    }
    
    //key board will dissmiss while touching screeng anywhere
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func performCalculation() {
        
        if priceTextField.text != "" {
            
            // automatically replace "," with "." to be able convert input text to Float
            
            let initialString = priceTextField.text!
            let formattedString = initialString.replacingOccurrences(of: ",", with: ".")
            
            if Float(formattedString) != nil {
                claimPrice = Float(formattedString)!
               // print(PriceTextField.text ?? "DEFAULT")
                //print("CLAIM PRICE \(claimPrice)")
            }
        }
        if sheetsNeeded == true {
            if Int(sheetsTextField.text!) != nil {
                let sheetsQuantity = Float(sheetsTextField.text!)
                fee = socialMinimum * min * sheetsQuantity!
            }
        } else {
        
            if percent != 0 && max == 0 {
                fee = claimPrice * percent / 100
                minimum = socialMinimum * min
                if fee < minimum {
                    fee = minimum
                }
            } else if percent != 0 && max != 0 {
                fee = claimPrice * percent / 100
                minimum = socialMinimum * min
                maximum = socialMinimum * max
                if fee < minimum {
                    fee = minimum
                }
                if fee > maximum {
                    fee = maximum
                }
                
            } else if percent == 0 && min != 0 {
                fee = socialMinimum * min
            } else if percentOfFirstInstanceFee != 0 {
                fee = claimPrice * percentOfFirstInstanceFee / 100
            }
        }
        
        
        //outputLabel.text = "Claim price = \(claimPrice)\nPercent = \(percent) \nMin = \(min)\nMax = \(max)\nPercentOfFirstInstanceFee = \(percentOfFirstInstanceFee)\nFee = \(fee)"
        //"Судовий збір становить \(fee) грн."
        outputLabel.text = "Сума судового збору:\n\(fee) грн."
        

    }

    @IBAction func button(_ sender: UIButton) {
        performCalculation()
        priceTextField.resignFirstResponder()
        sheetsTextField.resignFirstResponder()
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        performCalculation()
        return true
    }
    
    
}
