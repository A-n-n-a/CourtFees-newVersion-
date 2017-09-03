//
//  FirstTable.swift
//  Court Fee
//
//  Created by Anna on 8/6/17.
//  Copyright © 2017 Anna. All rights reserved.
//

import UIKit
import GoogleMobileAds

class FirstTable: UIViewController, UITableViewDelegate, UITableViewDataSource, GADBannerViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var myBanner: GADBannerView!
    var firstTableArray = [Section(section: "Оберіть дію, за яку справляється судовий збір", objects: ["За звернення до суду","За звернення до господарського суду", "За звернення до адміністративного суду", "За видачу судами документів", "У разі ухвалення судом постанови про накладення адміністративного стягнення"])]
    


    var secondArray = [
        ["За подання до суду:", "1) позовної заяви майнового характеру, яка подана:", "юридичною особою", "фізичною особою або фізичною особою - підприємцем","2) позовної заяви немайнового характеру, яка подана:", "юридичною особою або фізичною особою - підприємцем" + (String(describing:UnicodeScalar(0x00B9)!)), "фізичною особою" + (String(describing:UnicodeScalar(0x00B9)!)), "3) позовної заяви:", "про розірвання шлюбу", "про поділ майна при розірванні шлюбу", "4) заяви про видачу судового наказу; заяви у справах окремого провадження; заяви про забезпечення доказів або позову; заяви про перегляд заочного рішення; заяви про скасування рішення третейського суду; заяви про видачу виконавчого документа на примусове виконання рішення третейського суду; заяви про видачу виконавчого документа на підставі рішення іноземного суду; заяви про роз’яснення судового рішення, які подано:", "юридичною особою або фізичною особою - підприємцем" + (String(describing:UnicodeScalar(0x00B2)!)), "фізичною особою" + (String(describing:UnicodeScalar(0x00B2)!)), "5) позовної заяви про захист честі та гідності фізичної особи, ділової репутації фізичної або юридичної особи, а саме:", "позовної заяви немайнового характеру", "позовної заяви про відшкодування моральної шкоди", "6) апеляційної скарги на рішення суду; заяви про приєднання до апеляційної скарги на рішення суду; апеляційної скарги на судовий наказ, заяви про перегляд судового рішення у зв’язку з нововиявленими обставинами", "7) касаційної скарги на рішення суду; заяви про приєднання до касаційної скарги на рішення суду", "8) заяви про перегляд судових рішень Верховним Судом України", "9) апеляційної і касаційної скарги на ухвалу суду; заяви про приєднання до апеляційної чи касаційної скарги на ухвалу суду:", "юридичною особою або фізичною особою - підприємцем" + (String(describing:UnicodeScalar(0x00B3)!)), "фізичною особою" + (String(describing:UnicodeScalar(0x00B3)!))],
        ["За подання до господарського суду:","1) позовної заяви майнового характеру", "2) позовної заяви немайнового характеру", "3) заяви про вжиття запобіжних заходів та забезпечення позову; заяви про видачу виконавчого документа на підставі рішення іноземного суду; заяви про скасування рішення третейського суду; заяви про видачу виконавчого документа на примусове виконання рішення третейського суду; заяви про роз’яснення судового рішення", "4) апеляційної скарги на рішення суду; апеляційних скарг у справі про банкрутство; заяви про перегляд судового рішення у зв’язку з нововиявленими обставинами", "5) касаційної скарги на рішення суду; касаційних скарг у справі про банкрутство", "6) заяви про перегляд судових рішень Верховним Судом України", "7) апеляційної і касаційної скарги на ухвалу суду; заяви про приєднання до апеляційної чи касаційної скарги на ухвалу суду", "8) заяви про затвердження плану санації до порушення провадження у справі про банкрутство", "9) заяви про порушення справи про банкрутство", "10) заяви кредиторів, які звертаються з грошовими вимогами до боржника після оголошення про порушення справи про банкрутство, а також після повідомлення про визнання боржника банкрутом; заяви про визнання правочинів (договорів) недійсними та спростування майнових дій боржника в межах провадження у справі про банкрутство; заяви про розірвання мирової угоди, укладеної у справі про банкрутство, або визнання її недійсною"],
         ["За подання до адміністративного суду:", "1) адміністративного позову майнового характеру, який подано:", "суб’єктом владних повноважень, юридичною особою", "фізичною особою або фізичною особою - підприємцем", "адміністративного позову немайнового характеру, який подано:", "суб’єктом владних повноважень, юридичною особою або фізичною особою - підприємцем", "фізичною особою", "2) апеляційної скарги на рішення суду, заяви про приєднання до апеляційної скарги на рішення суду, заяви про перегляд судового рішення у зв’язку з нововиявленими обставинами", "3) касаційної скарги на рішення суду, заяви про приєднання до касаційної скарги на рішення суду", "4) заяви про перегляд судового рішення Верховним Судом України", "5) апеляційної і касаційної скарги на ухвалу суду; заяви про приєднання до апеляційної чи касаційної скарги на ухвалу суду", "6) заяви про забезпечення доказів або позову, заяви про видачу виконавчого документа на підставі рішення іноземного суду, заяви про зміну чи встановлення способу, порядку і строку виконання судового рішення"],
        ["За видачу судами документів:", "1) за повторну видачу копії судового рішення", "2) за видачу дубліката судового наказу та виконавчого листа", "3) за роздрукування технічного запису судового засідання", "4) за видачу в електронному вигляді копії технічного запису судового засідання", "5) за виготовлення копії судового рішення у разі, якщо особа, яка не бере (не брала) участі у справі, якщо судове рішення безпосередньо стосується її прав, свобод, інтересів чи обов’язків, звертається до апарату відповідного суду з письмовою заявою про виготовлення такої копії згідно із Законом України 'Про доступ до судових рішень'", "6) за виготовлення копій документів, долучених до справи"],
        ["У разі ухвалення судом постанови про накладення адміністративного стягнення"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.clear
        
        //self-resizing cell
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        self.navigationController?.navigationBar.isHidden = false
        
        // ad banner
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        myBanner.adUnitID = "ca-app-pub-4375494746414239/6254715307"
        myBanner.rootViewController = self
        myBanner.delegate = self
        myBanner.load(request)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return firstTableArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firstTableArray[section].objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CellClass
        cell.labelCell?.text = firstTableArray[indexPath.section].objects[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath: NSIndexPath = self.tableView.indexPathForSelectedRow! as NSIndexPath
        let destViewController = segue.destination as! SecondTableView
        destViewController.displeyedArray = secondArray[indexPath.row]
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = nil
    }
}
