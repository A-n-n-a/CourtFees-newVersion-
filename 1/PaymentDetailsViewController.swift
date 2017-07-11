//
//  ViewController.swift
//  Судовий збір. Реквізити
//
//  Created by Anna on 12.05.17.
//  Copyright © 2017 Anna. All rights reserved.
//

import UIKit

class PaymentDetailsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var output: UILabel!

    
    struct Rekvizit {
        var name: Any
        var payee: String
        var zkpo: String
        var bank: String
        var mfo: String
        var account: String
        var code: String
        var symbol: String
        
        init (name: String, payee: String, zkpo: String, bank: String, mfo: String, account: String, code: String, symbol: String) {
            self.name = name
            self.payee = payee
            self.zkpo = zkpo
            self.bank = bank
            self.mfo = mfo
            self.account = account
            self.code = code
            self.symbol = symbol
        }
    }

    var structArray = [Rekvizit]()
    var someStruct = Rekvizit(name: "", payee: "", zkpo: "", bank: "", mfo: "", account: "", code: "", symbol: "")
    var index = 0
    var tempstring = ""
    
    let districts = ["Автономна Республіка Крим", "Вінницька область", "Волинська область", "Дніпропетровська область", "Донецька область", "Житомирська область", "Закарпатська область", "Запорізька область", "Івано-Франківська область", "місто Київ", "Київська область", "Кіровоградська область", "Луганська область", "Львівська область", "Миколаївська область", "Одеська область", "Полтавська область", "Рівненська область", "Сумська область", "Тернопільська область", "Харківська область", "Херсонська область", "Хмельницька область", "Черкаська область", "Чернігівська область", "Черновицька область", "місто Севастополь"]
    
    //key board will dissmiss while touching screeng anywhere
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        text.delegate = self
        
        //Declaration
        
        var namesArray = [String]()
        var payeeArray = [String]()
        var zkpoArray = [String]()
        var bankArray = [String]()
        var mfoArray = [String]()
        var accountArray = [String]()
        var codeArray = [String]()
        var symbolArray = [String]()
        
        /*var courtSum = 0
        var vinnitsa = [String]()
        var volyn = [String]()
        var dnipro = [String]()
        var donetsk = [String]()
        var zhytomyr = [String]()
        var zakarpatta = [String]()
        var zaporizza = [String]()
        var ivFr = [String]()
        var kyiv = [String]()
        var kyivska = [String]()
        var kyrovograd = [String]()
        var lugansk = [String]()
        var lviv = [String]()
        var mykolaiv = [String]()
        var odessa = [String]()
        var poltava = [String]()
        var rivne = [String]()
        var sumy = [String]()
        var ternopil = [String]()
        var kharkiv = [String]()
        var kherson = [String]()
        var khmelnitskiy = [String]()
        var cherkasy = [String]()
        var chernigiv = [String]()
        var chernivtsi = [String]()
        */
        
        
        
        //JSON
        guard let path = Bundle.main.path(forResource: "Fees", ofType: "json") else {
            return
        }
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            //print(json)
            
            guard let array = json as? [Any] else {
             return
            }
           // print("ARRAY\n\(array)")
            for court in array {
                guard let courtDict = court as? [String:Any] else { return}
                guard (courtDict["crt_name"] as? String) != nil else {print("Not a String"); return}
                guard (courtDict["tax_payee"] as? String) != nil else {print("Not a String"); return}
                guard (courtDict["tax_zkpo"] as? String) != nil else {print("Not a String"); return}
                guard (courtDict["tax_bank"] as? String) != nil else {print("Not a String"); return}
                guard (courtDict["tax_mfo"] as? String) != nil else {print("Not a String"); return}
                guard (courtDict["tax_account"] as? String) != nil else {print("Not a String"); return}
                guard (courtDict["tax_code"] as? String) != nil else {print("Not a String"); return}
                guard (courtDict["tax_symbol"] as? String) != nil else {print("Not a String"); return}
                //print(courtName)
                namesArray.append(courtDict["crt_name"] as! String)
                payeeArray.append(courtDict["tax_payee"] as! String)
                zkpoArray.append(courtDict["tax_zkpo"] as! String)
                bankArray.append(courtDict["tax_bank"] as! String)
                mfoArray.append(courtDict["tax_mfo"] as! String)
                accountArray.append(courtDict["tax_account"] as! String)
                codeArray.append(courtDict["tax_code"] as! String)
                symbolArray.append(courtDict["tax_symbol"] as! String)
                
                someStruct.name = namesArray[index]
                someStruct.payee = payeeArray[index]
                someStruct.zkpo = zkpoArray[index]
                someStruct.bank = bankArray[index]
                someStruct.mfo = mfoArray[index]
                someStruct.account = accountArray[index]
                someStruct.code = codeArray[index]
                someStruct.symbol = symbolArray[index]
                index += 1
                structArray.append(someStruct)
            
                
            }
            print("COUNT: \(structArray.count)")
            
            /*for i in structArray {
                let x = i.name as? String, y = String(i.bank)
                if (x?.range(of: "Вінн") != nil) || y?.range(of: "Вінн") != nil {
                    vinnitsa.append(x!)
                }
                if (x?.range(of: "Волинської") != nil) || (x?.range(of: "Луцьк") != nil) || y?.range(of: "Волинської") != nil || y?.range(of: "Волинській") != nil {
                    volyn.append(x!)
                }
                if (x?.range(of: "Дніпропетр") != nil) || y?.range(of: "Дніпропетр") != nil {
                    dnipro.append(x!)
                }
                if (x?.range(of: "Донец") != nil) || (x?.range(of: "Горлівк") != nil) || y?.range(of: "Донец") != nil {
                    donetsk.append(x!)
                }
                if (x?.range(of: "Житом") != nil) || y?.range(of: "Житом") != nil {
                    zhytomyr.append(x!)
                }
                if (x?.range(of: "Запор") != nil) || y?.range(of: "Запор") != nil {
                    zaporizza.append(x!)
                }
                if (x?.range(of: "Закарп") != nil) || (x?.range(of: "Ужг") != nil) || y?.range(of: "Закарп") != nil || y?.range(of: "Ужг") != nil {
                    zakarpatta.append(x!)
                }
                if (x?.range(of: "Івано-Фра") != nil) || y?.range(of: "Івано-Фра") != nil {
                    ivFr.append(x!)
                }
                if (x?.range(of: "Києва") != nil)  {
                    kyiv.append(x!)
                }
                if (x?.range(of: "Київської") != nil) || x?.range(of: "Київський апеляційний") != nil || x?.range(of: "Київський окружний") != nil {
                    kyivska.append(x!)
                }
                if (x?.range(of: "Кіровогр") != nil) || y?.range(of: "Кіровогр") != nil {
                    kyrovograd.append(x!)
                }
                if (x?.range(of: "Луган") != nil) || y?.range(of: "Луган") != nil {
                    lugansk.append(x!)
                }
                if (x?.range(of: "Льв") != nil) || y?.range(of: "Льв") != nil {
                    lviv.append(x!)
                }
                if (x?.range(of: "Миколаєва") != nil) || (x?.range(of: "Миколаївської") != nil) || (x?.range(of: "Миколаївський окружний") != nil) || y?.range(of: "Миколаїв") != nil {
                    mykolaiv.append(x!)
                }
                if (x?.range(of: "Одес") != nil) || y?.range(of: "Одес") != nil {
                    odessa.append(x!)
                }
                if (x?.range(of: "Полтав") != nil) || y?.range(of: "Полтав") != nil {
                    poltava.append(x!)
                }
                if (x?.range(of: "Рівн") != nil) || y?.range(of: "Рівн") != nil {
                    rivne.append(x!)
                }
                if (x?.range(of: "Сум") != nil) || y?.range(of: "Сум") != nil {
                    sumy.append(x!)
                }
                if (x?.range(of: "Терноп") != nil) || y?.range(of: "Терноп") != nil {
                    ternopil.append(x!)
                }
                if (x?.range(of: "Харк") != nil)  {
                    kharkiv.append(x!)
                }
                if (x?.range(of: "Херс") != nil) || y?.range(of: "Херс") != nil {
                    kherson.append(x!)
                }
                if (x?.range(of: "Хмельницької") != nil) || (x?.range(of: "Хмельницький окружний") != nil) || y?.range(of: "Хмельниц") != nil {
                    khmelnitskiy.append(x!)
                }
                if (x?.range(of: "Черкас") != nil) || y?.range(of: "Черкас") != nil {
                    cherkasy.append(x!)
                }
                if (x?.range(of: "Чернігівської") != nil) || (x?.range(of: "Чернігівський окружний") != nil) || (x?.range(of: "Чернігова") != nil) || y?.range(of: "Черніг") != nil {
                    chernigiv.append(x!)
                }
                if (x?.range(of: "Чернівецької") != nil) || (x?.range(of: "Чернівців") != nil) || (x?.range(of: "Чернівецький окружний") != nil) ||  y?.range(of: "Чернів") != nil {
                    chernivtsi.append(x!)
                }

            }*/

            
        }
        catch {
            print(error)
        }

   }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        performAction()
        return true
    }
    
    func performAction () -> () {
        for i in structArray {
            let name = i.name as! String
            let lowName = name.lowercased()
            let input = text.text?.lowercased()
            if input?.lowercased() == name.lowercased() || (lowName.range(of: input!) != nil) {
                text.placeholder = name
                output.text = "Платiжнi реквiзити для перерахування судового збору в гривнях\n\n\(i.name)\n\nОтримувач коштів:  \(i.payee) \nКод отримувача (код за ЄДРПОУ):  \(i.zkpo)\nБанк отримувача:  \(i.bank)\nКод банку отримувача (МФО):  \(i.mfo)\nРахунок отримувача:  \(i.account)\nКод класифікації доходів бюджету:  \(i.code)\nПризначення платежу: *;101;__________(ІПН/ЄДРПОУ платника);Судовий збір, за позовом ___________ (ПІБ/назва), \(i.name)"
            //} else {
               // output.text = "Не знайдено"
            }
        }
    }

    @IBAction func searchButton(_ sender: UIButton) {
        performAction()
    }

        
    

    
}

