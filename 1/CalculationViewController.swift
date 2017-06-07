

import UIKit

class CalculationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var sheetsLabel: UILabel!
    @IBOutlet weak var PriceTextField: UITextField!
    @IBOutlet weak var sheetsTextField: UITextField!
    
   
    let socialMinimum: Float = 1600.00
    
    var percent = Float()
    var min = Float()
    var max = Float()
    var percentOfFirstInstanceFee = Float()
    
    var minimum = Float()
    var maximum = Float()
    var fee = Float()
    var claimPrice = Float()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        claimPrice = 100000.00
        
        PriceTextField.delegate = self
        sheetsTextField.delegate = self

        
        if PriceTextField.text != "" && Float(PriceTextField.text!) != nil {
            claimPrice = Float(PriceTextField.text!)!
            
        }
        
        if percentOfFirstInstanceFee != 0 {
            inputLabel.text = "Введіть розмір ставки судового збору, що підлягала сплаті при поданні позовної заяви, іншої заяви і скарги"
            
        } else {
            inputLabel.text = "Введіть ціну позову"
        }

        
        
    }
    
    //key board will dissmiss while touching screeng anywhere
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func performCalculation() {
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
        
        
        outputLabel.text = "Claim price = \(claimPrice)\nPercent = \(percent) \nMin = \(min)\nMax = \(max)\nPercentOfFirstInstanceFee = \(percentOfFirstInstanceFee)\nFee = \(fee)"
        //"Судовий збір становить \(fee) грн."
        
        

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
