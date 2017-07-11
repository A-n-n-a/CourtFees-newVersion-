

import UIKit
import Firebase
import FirebaseDatabase



class CalculationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var sheetsLabel: UILabel!
    @IBOutlet weak var PriceTextField: UITextField!
    @IBOutlet weak var sheetsTextField: UITextField!
    @IBOutlet weak var button: UIButton!
    
   
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
       
        
        PriceTextField.delegate = self
        sheetsTextField.delegate = self

        
        if percentOfFirstInstanceFee != 0 {
            inputLabel.text = "Введіть розмір ставки судового збору, що підлягала сплаті при поданні позовної заяви, іншої заяви і скарги"
            
        } else {
            if percent != 0 {
                inputLabel.text = "Введіть ціну позову"
            } else {
                inputLabel.text = ""
                PriceTextField.isHidden = true
                if sheetsNeeded == false{
                    button.isHidden = true
                    fee = socialMinimum * min
                    outputLabel.text = "Сума судового збору:\n\(fee) грн."
                    outputLabel.center.y = self.view.frame.size.height/2
                }
            }
        }
        
        if sheetsNeeded == false {
            sheetsLabel.isHidden = true
            sheetsTextField.isHidden = true
        }

        
    }
    
    //key board will dissmiss while touching screeng anywhere
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func performCalculation() {
        
        if PriceTextField.text != "" {
            
            // automatically replace "," with "." to be able convert input text to Float
            
            let initialString = PriceTextField.text!
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
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        performCalculation()
        return true
    }
    
    
}
