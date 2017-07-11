//
//  SecondTableViewController.swift
//  1
//
//  Created by Anna on 05.06.17.
//  Copyright © 2017 Anna. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SecondTableViewController: UITableViewController {
    
    var ref: DatabaseReference? = Database.database().reference()
    
    var sections = [String]()
    var objects = [[String]]()
    
    var selectedRow = SecondTableViewCell()
    
    let indexPath = IndexPath()
    
    var socialMinimum = Float()
    
    var calculationArray = [CalculationDetails(condition: "юридичною особою", percent: 1.5, min: 1, max: nil, percentOfFirstInstanceFee: nil, sheetsNeeded: false),
                            CalculationDetails(condition: "фізичною особою або фізичною особою - підприємцем", percent: 1, min: 0.4, max: nil, percentOfFirstInstanceFee: nil, sheetsNeeded: false),
                            CalculationDetails(condition: "юридичною особою або фізичною особою - підприємцем" + (String(describing:UnicodeScalar(0x00B9)!)), percent: nil, min: 1, max: nil, percentOfFirstInstanceFee: nil, sheetsNeeded: false),
                            CalculationDetails(condition: "фізичною особою" + (String(describing:UnicodeScalar(0x00B9)!)), percent: nil, min: 0.4, max: nil, percentOfFirstInstanceFee: nil, sheetsNeeded: false),
                            CalculationDetails(condition: "про розірвання шлюбу", percent: nil, min: 0.4, max: nil, percentOfFirstInstanceFee: nil, sheetsNeeded: false),
                            CalculationDetails(condition: "про поділ майна при розірванні шлюбу", percent: 1, min: 0.4, max: 3, percentOfFirstInstanceFee: nil, sheetsNeeded: false),
                            CalculationDetails(condition: "юридичною особою або фізичною особою - підприємцем" + (String(describing:UnicodeScalar(0x00B2)!)), percent: nil, min: 0.5, max: nil, percentOfFirstInstanceFee: nil, sheetsNeeded: false),
                            CalculationDetails(condition: "фізичною особою" + (String(describing:UnicodeScalar(0x00B2)!)), percent: nil, min: 0.2, max: nil, percentOfFirstInstanceFee: nil, sheetsNeeded: false),
                            CalculationDetails(condition: "позовної заяви немайнового характеру", percent: nil, min: 0.4, max: nil, percentOfFirstInstanceFee: nil, sheetsNeeded: false),
                            CalculationDetails(condition: "позовної заяви про відшкодування моральної шкоди", percent: 1.5, min: 1, max: nil, percentOfFirstInstanceFee: nil, sheetsNeeded: false),
                            CalculationDetails(condition: "6) апеляційної скарги на рішення суду; заяви про приєднання до апеляційної скарги на рішення суду; апеляційної скарги на судовий наказ, заяви про перегляд судового рішення у зв’язку з нововиявленими обставинами", percent: nil, min: nil, max: nil, percentOfFirstInstanceFee: 110, sheetsNeeded: false),
                            CalculationDetails(condition: "7) касаційної скарги на рішення суду; заяви про приєднання до касаційної скарги на рішення суду", percent: nil, min: nil, max: nil, percentOfFirstInstanceFee: 120, sheetsNeeded: false),
                            CalculationDetails(condition: "8) заяви про перегляд судових рішень Верховним Судом України", percent: nil, min: nil, max: nil, percentOfFirstInstanceFee: 130, sheetsNeeded: false),
                            CalculationDetails(condition: "юридичною особою або фізичною особою - підприємцем" + (String(describing:UnicodeScalar(0x00B3)!)), percent: nil, min: 1, max: nil, percentOfFirstInstanceFee: nil, sheetsNeeded: false),
                            CalculationDetails(condition: "фізичною особою" + (String(describing:UnicodeScalar(0x00B3)!)), percent: nil, min: 0.2, max: nil, percentOfFirstInstanceFee: nil, sheetsNeeded: false),
                            CalculationDetails(condition: "1) позовної заяви майнового характеру", percent: 1.5, min: 1, max: 150, percentOfFirstInstanceFee: nil, sheetsNeeded: false),
                            CalculationDetails(condition: "2) позовної заяви немайнового характеру", percent: nil, min: 1, max: nil, percentOfFirstInstanceFee: nil, sheetsNeeded: false),
                            CalculationDetails(condition: "3) заяви про вжиття запобіжних заходів та забезпечення позову; заяви про видачу виконавчого документа на підставі рішення іноземного суду; заяви про скасування рішення третейського суду; заяви про видачу виконавчого документа на примусове виконання рішення третейського суду; заяви про роз’яснення судового рішення", percent: nil, min: 0.5, max: nil, percentOfFirstInstanceFee: nil, sheetsNeeded: false),
                            CalculationDetails(condition: "4) апеляційної скарги на рішення суду; апеляційних скарг у справі про банкрутство; заяви про перегляд судового рішення у зв’язку з нововиявленими обставинами", percent: nil, min: nil, max: nil, percentOfFirstInstanceFee: 110, sheetsNeeded: false),
                            CalculationDetails(condition: "5) касаційної скарги на рішення суду; касаційних скарг у справі про банкрутство", percent: nil, min: nil, max: nil, percentOfFirstInstanceFee: 120, sheetsNeeded: false),
                            CalculationDetails(condition: "6) заяви про перегляд судових рішень Верховним Судом України", percent: nil, min: nil, max: nil, percentOfFirstInstanceFee: 130, sheetsNeeded: false),
                            CalculationDetails(condition: "7) апеляційної і касаційної скарги на ухвалу суду; заяви про приєднання до апеляційної чи касаційної скарги на ухвалу суду", percent: nil, min: 1, max: nil, percentOfFirstInstanceFee: nil, sheetsNeeded: false),
                            CalculationDetails(condition: "8) заяви про затвердження плану санації до порушення провадження у справі про банкрутство", percent: nil, min: 2, max: nil, percentOfFirstInstanceFee: nil, sheetsNeeded: false),
                            CalculationDetails(condition: "9) заяви про порушення справи про банкрутство", percent: nil, min: 10, max: nil, percentOfFirstInstanceFee: nil, sheetsNeeded: false),
                            CalculationDetails(condition: "10) заяви кредиторів, які звертаються з грошовими вимогами до боржника після оголошення про порушення справи про банкрутство, а також після повідомлення про визнання боржника банкрутом; заяви про визнання правочинів (договорів) недійсними та спростування майнових дій боржника в межах провадження у справі про банкрутство; заяви про розірвання мирової угоди, укладеної у справі про банкрутство, або визнання її недійсною", percent: nil, min: 2, max: nil, percentOfFirstInstanceFee: nil, sheetsNeeded: false),
                            CalculationDetails(condition: "суб’єктом владних повноважень, юридичною особою", percent: 1.5, min: 1, max: nil, percentOfFirstInstanceFee: nil, sheetsNeeded: false),
                            CalculationDetails(condition: "фізичною особою або фізичною особою - підприємцем", percent: 1, min: 0.4, max: 5, percentOfFirstInstanceFee: nil, sheetsNeeded: false),
                            CalculationDetails(condition: "суб’єктом владних повноважень, юридичною особою або фізичною особою - підприємцем", percent: nil, min: 1, max: nil, percentOfFirstInstanceFee: nil, sheetsNeeded: false),
                            CalculationDetails(condition: "фізичною особою", percent: nil, min: 0.4, max: nil, percentOfFirstInstanceFee: nil, sheetsNeeded: false),
                            CalculationDetails(condition: "2) апеляційної скарги на рішення суду, заяви про приєднання до апеляційної скарги на рішення суду, заяви про перегляд судового рішення у зв’язку з нововиявленими обставинами", percent: nil, min: nil, max: nil, percentOfFirstInstanceFee: 110, sheetsNeeded: false),
                            CalculationDetails(condition: "3) касаційної скарги на рішення суду, заяви про приєднання до касаційної скарги на рішення суду", percent: nil, min: nil, max: nil, percentOfFirstInstanceFee: 120, sheetsNeeded: false),
                            CalculationDetails(condition: "4) заяви про перегляд судового рішення Верховним Судом України", percent: nil, min: nil, max: nil, percentOfFirstInstanceFee: 130, sheetsNeeded: false),
                            CalculationDetails(condition: "5) апеляційної і касаційної скарги на ухвалу суду; заяви про приєднання до апеляційної чи касаційної скарги на ухвалу суду", percent: nil, min: 1, max: nil, percentOfFirstInstanceFee: nil, sheetsNeeded: false),
                            CalculationDetails(condition: "6) заяви про забезпечення доказів або позову, заяви про видачу виконавчого документа на підставі рішення іноземного суду, заяви про зміну чи встановлення способу, порядку і строку виконання судового рішення", percent: nil, min: 0.3, max: nil, percentOfFirstInstanceFee: nil, sheetsNeeded: false),
                            CalculationDetails(condition: "1) за повторну видачу копії судового рішення", percent: nil, min: 0.003, max: nil, percentOfFirstInstanceFee: nil, sheetsNeeded: true),
                            CalculationDetails(condition: "2) за видачу дубліката судового наказу та виконавчого листа", percent: nil, min: 0.03, max: nil, percentOfFirstInstanceFee: nil, sheetsNeeded: false),
                            CalculationDetails(condition: "3) за роздрукування технічного запису судового засідання", percent: nil, min: 0.01, max: nil, percentOfFirstInstanceFee: nil, sheetsNeeded: true),
                            CalculationDetails(condition: "4) за видачу в електронному вигляді копії технічного запису судового засідання", percent: nil, min: 0.03, max: nil, percentOfFirstInstanceFee: nil, sheetsNeeded: false),
                            CalculationDetails(condition: "5) за виготовлення копії судового рішення у разі, якщо особа, яка не бере (не брала) участі у справі, якщо судове рішення безпосередньо стосується її прав, свобод, інтересів чи обов’язків, звертається до апарату відповідного суду з письмовою заявою про виготовлення такої копії згідно із Законом України 'Про доступ до судових рішень'", percent: nil, min: 0.003, max: nil, percentOfFirstInstanceFee: nil, sheetsNeeded: true),
                            CalculationDetails(condition: "6) за виготовлення копій документів, долучених до справи", percent: nil, min: 0.003, max: nil, percentOfFirstInstanceFee: nil, sheetsNeeded: true),
                            CalculationDetails(condition: "У разі ухвалення судом постанови про накладення адміністративного стягнення", percent: nil, min: 0.2, max: nil, percentOfFirstInstanceFee: nil, sheetsNeeded: false)]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self-resizing cell
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        //set the background
        if let tableView = self.view as? UITableView {
            let image = UIImage(named: "structure-2163469_960_720")
            let imageView = UIImageView(image: image)
            tableView.backgroundView = imageView
        }
        
        
        //retrieve data from Firebase
        self.ref?.child("socialMinimum").observe(.value, with: { (snapshot) in
            
            if let value = snapshot.value as? String {
                
                if Float(value) != nil {
                    self.socialMinimum = Float(value)!
                    print("INSIDE: \(self.socialMinimum)")
                    //self.viewDidLoad()
                    //self.loadView()
                    
                }
            }
            
        })


    }




    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objects[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondCell", for: indexPath) as! SecondTableViewCell

        cell.labelCell?.text = self.objects[indexPath.section][indexPath.row]
        cell.labelCell?.textColor = UIColor(white: 1.0, alpha: 1.0)

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destViewController = segue.destination as! CalculationViewController
        //парсим массив на структуры, индекс элемента массива - номер выбранной строки
        
        let selectedRowIndex = self.tableView.indexPathForSelectedRow
        selectedRow = self.tableView.cellForRow(at: selectedRowIndex!)! as! SecondTableViewCell
        
        /*if  selectedRow.textLabel?.text == "1) за повторну видачу копії судового рішення" ||
            selectedRow.textLabel?.text == "3) за роздрукування технічного запису судового засідання" ||
            selectedRow.textLabel?.text == "5) за виготовлення копії судового рішення у разі, якщо особа, яка не бере (не брала) участі у справі, якщо судове рішення безпосередньо стосується її прав, свобод, інтересів чи обов’язків, звертається до апарату відповідного суду з письмовою заявою про виготовлення такої копії згідно із Законом України 'Про доступ до судових рішень'" ||
            selectedRow.textLabel?.text == "6) за виготовлення копій документів, долучених до справи" {
            if destViewController.sheetsLabel != nil {
                destViewController.sheetsLabel.isHidden = false
            }
            //if destViewController.sheetsTextField != nil {
            destViewController.sheetsTextField.isHidden = false
            
        }*/
        //print(selectedRow.labelCell?.text ?? "DEFAULT")
        for i in calculationArray {
            
            if i.condition == selectedRow.labelCell?.text {
                if i.percent != nil {
                    destViewController.percent = i.percent!
                    print(destViewController.percent)
                } else {
                    destViewController.percent = 0
                    print(destViewController.percent)
                }
                if i.min != nil {
                    destViewController.min = i.min!
                    print("MIN: \(destViewController.min)")
                } else {
                    destViewController.min = 0
                    print(destViewController.min)
                }
                if i.max != nil {
                    destViewController.max = i.max!
                    print(destViewController.max)
                } else {
                    destViewController.max = 0
                    print(destViewController.max)
                }
                if i.percentOfFirstInstanceFee != nil {
                    destViewController.percentOfFirstInstanceFee = i.percentOfFirstInstanceFee!
                    print(destViewController.percentOfFirstInstanceFee)
                } else {
                    destViewController.percentOfFirstInstanceFee = 0
                    print(destViewController.percentOfFirstInstanceFee)
                }
                
                destViewController.sheetsNeeded = i.sheetsNeeded
                destViewController.socialMinimum = self.socialMinimum
                print("SOCIAL MINIMUM: \(socialMinimum)")
                
                
            }
        }
        
        //print("Condition: \(i.condition)")
        //print("Selected row: \(selectedRow.textLabel!.text!)")
       
    }
    



    
}
