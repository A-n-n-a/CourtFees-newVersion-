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
    
    var ref: DatabaseReference? = Database.database().reference()

    var structArray = [Rekvizit]()
    var someStruct = Rekvizit(name: "", payee: "", zkpo: "", bank: "", mfo: "", account: "", code: "", symbol: "")
    var index = 0
    var tempstring = ""
    
    var namesArray = [String]()
    var payeeArray = [String]()
    var zkpoArray = [String]()
    var bankArray = [String]()
    var mfoArray = [String]()
    var accountArray = [String]()
    var codeArray = [String]()
    var symbolArray = [String]()
    
    var dropDownArray = [String]()
    
    var exeptionArray = [String]()
    var exeptionArrayCount = Int()
    var courtsCount = Int()
    
    //let districts = ["Автономна Республіка Крим", "Вінницька область", "Волинська область", "Дніпропетровська область", "Донецька область", "Житомирська область", "Закарпатська область", "Запорізька область", "Івано-Франківська область", "місто Київ", "Київська область", "Кіровоградська область", "Луганська область", "Львівська область", "Миколаївська область", "Одеська область", "Полтавська область", "Рівненська область", "Сумська область", "Тернопільська область", "Харківська область", "Херсонська область", "Хмельницька область", "Черкаська область", "Чернігівська область", "Черновицька область", "місто Севастополь"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        text.delegate = self
        
        dropDown.isHidden = true
        dropDown.rowHeight = 20
        
        //self.navigationController?.navigationItem.title = "Назад"
        self.navigationController!.navigationBar.topItem!.title = "Назад"
        //dropDownHeight.constant = dropDown.contentSize.height
//        var frame = dropDown.frame
//        frame.size.height = dropDown.contentSize.height
//        dropDown.frame = frame
        //dropDown.tableFooterView = UIView()
        
        

        
        
        //Declaration
        let viewHeight = self.view.frame.size.height
        let viewWidth = self.view.frame.size.width
        
//        print("HEIGHT: \(viewHeight)")
//        print("WIDTH: \(viewWidth)")
        
        
        
        let device = UIDevice.current
        
        if device.orientation.isLandscape {
            let widthConstraint = NSLayoutConstraint(item: text, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: (viewWidth - 80))
            view.addConstraints([widthConstraint])
            //print("LANDSCAPE")
            //print(widthConstraint)
        } else {
            let widthConstraint = NSLayoutConstraint(item: text, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: (viewWidth - 80))
            view.addConstraints([widthConstraint])

        }
    
        
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
        //print("EXEPTIONS COUNT: \(exeptionArrayCount)")
//        self.ref?.child("exeptionArray").observe(.value, with: { (snapshot) in
//            if let value = snapshot.value as? [String : AnyObject] {
//                for i in 0..<self.exeptionArrayCount {
//                    let string = String(i)
//                    self.exeptionArray.append(value[string] as! String)
//                }
//            }
//        })
//        self.ref?.child("exeptionArray").observe(.value, with: { (snapshot) in
//            print("SNAPSHOT: \(snapshot.value)")
//            if let value = snapshot.value as? [String] {
//                self.exeptionArray = value
//                //                for i in 0..<self.exeptionArrayCount {
//                //                    let string = String(i)
//                //                    self.exeptionArray.append(value[string] as! String)
//                //                }
//            }
//        })
        
        var index = 0
       // print("CORTS COUNT: \(courtsCount)")
        for _ in 0..<courtsCount {
            self.ref?.child(String(index)
                ).observe(.value, with: { (snapshot) in
                
                if let value = snapshot.value as? [String : AnyObject] {
                    
                    self.namesArray.append(value["crt_name"] as! String)
                    self.payeeArray.append(value["tax_payee"] as! String)
                    self.zkpoArray.append(value["tax_zkpo"] as! String)
                    self.bankArray.append(value["tax_bank"] as! String)
                    self.mfoArray.append(value["tax_mfo"] as! String)
                    self.accountArray.append(value["tax_account"] as! String)
                    self.codeArray.append(value["tax_code"] as! String)
                    self.symbolArray.append(value["tax_symbol"] as! String)
                    
                    self.someStruct.name = self.namesArray[index]
                    self.someStruct.payee = self.payeeArray[index]
                    self.someStruct.zkpo = self.zkpoArray[index]
                    self.someStruct.bank = self.bankArray[index]
                    self.someStruct.mfo = self.mfoArray[index]
                    self.someStruct.account = self.accountArray[index]
                    self.someStruct.code = self.codeArray[index]
                    self.someStruct.symbol = self.symbolArray[index]
                    index += 1
                    self.structArray.append(self.someStruct)
                }
                
            })

        }
        
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
        
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        
        myBanner.adUnitID = "ca-app-pub-4375494746414239/6254715307"
        myBanner.rootViewController = self
        myBanner.delegate = self
        myBanner.load(request)

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

        for i in structArray {
            let name = i.name as! String
            let lowName = name.lowercased()
            let input = text.text?.lowercased()
//            if input?.lowercased() == lowName || (lowName.range(of: input!) != nil) {
//                //text.placeholder = name
//                output.text = "Платiжнi реквiзити для перерахування судового збору в гривнях\n\n\(i.name)\n\nОтримувач коштів:  \(i.payee) \nКод отримувача (код за ЄДРПОУ):  \(i.zkpo)\nБанк отримувача:  \(i.bank)\nКод банку отримувача (МФО):  \(i.mfo)\nРахунок отримувача:  \(i.account)\nКод класифікації доходів бюджету:  \(i.code)\nПризначення платежу: *;101;__________(ІПН/ЄДРПОУ платника);Судовий збір, за позовом ___________ (ПІБ/назва), \(i.name)"
//            //} else {
//               // output.text = "Не знайдено"
//              dropDownArray.append(name)
//            }
            for x in exeptionArray {
                //print(x)
                if x.lowercased() == input?.lowercased() {
                    output.text = "Даний суд знаходиться в районі проведення антитерористичної операції і не може здійснювати правосуддя. Згідно Закону України 'Про здійснення правосуддя та кримінального провадження у зв’язку з проведенням антитерористичної операції' справи, підсудні даному суду, розглядаються судами, що визначаються головою Вищого спеціалізованого суду України з розгляду цивільних і кримінальних справ"
                    break
                } else {
                    if input?.lowercased() == lowName || (lowName.range(of: input!) != nil) {
                        //text.placeholder = name
                        output.text = "Платiжнi реквiзити для перерахування судового збору в гривнях\n\n\(i.name)\n\nОтримувач коштів:  \(i.payee) \nКод отримувача (код за ЄДРПОУ):  \(i.zkpo)\nБанк отримувача:  \(i.bank)\nКод банку отримувача (МФО):  \(i.mfo)\nРахунок отримувача:  \(i.account)\nКод класифікації доходів бюджету:  \(i.code)\nПризначення платежу: *;101;__________(ІПН/ЄДРПОУ платника);Судовий збір, за позовом ___________ (ПІБ/назва), \(i.name)"
                        //} else {
                        // output.text = "Не знайдено"
                        dropDownArray.append(name)
                    }

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
            for i in structArray {
                let name = i.name as! String
                let lowName = name.lowercased()
                let input = text.text?.lowercased()
                if input?.lowercased() == lowName || (lowName.range(of: input!) != nil) {
                    dropDownArray.append(name)
                    self.dropDown.reloadData()
                    //print(dropDownArray)
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

