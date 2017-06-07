

import UIKit
import Foundation


class FirstTableViewController: UITableViewController {

    
    var firstTableArray = [Section(section: "Оберіть дію, за яку справляється судовий збір", objects: ["За звернення до суду","За звернення до господарського суду", "За звернення до адміністративного суду", "За видачу судами документів", "У разі ухвалення судом постанови про накладення адміністративного стягнення"])]
    
    var secondArray =
        [SecondTable(section: ["За подання до суду:", "1) позовної заяви майнового характеру, яка подана:","2) позовної заяви немайнового характеру, яка подана:", "3) позовної заяви:", "4) заяви про видачу судового наказу; заяви у справах окремого провадження; заяви про забезпечення доказів або позову; заяви про перегляд заочного рішення; заяви про скасування рішення третейського суду; заяви про видачу виконавчого документа на примусове виконання рішення третейського суду; заяви про видачу виконавчого документа на підставі рішення іноземного суду; заяви про роз’яснення судового рішення, які подано:","5) позовної заяви про захист честі та гідності фізичної особи, ділової репутації фізичної або юридичної особи, а саме:", "9) апеляційної і касаційної скарги на ухвалу суду; заяви про приєднання до апеляційної чи касаційної скарги на ухвалу суду:"], objects: [[], ["юридичною особою", "фізичною особою або фізичною особою - підприємцем"],["юридичною особою або фізичною особою - підприємцем", "фізичною особою."], ["про розірвання шлюбу", "про поділ майна при розірванні шлюбу"], ["юридичною особою або фізичною особою - підприємцем.", "фізичною особою"],  ["позовної заяви немайнового характеру", "позовної заяви про відшкодування моральної шкоди", "6) апеляційної скарги на рішення суду; заяви про приєднання до апеляційної скарги на рішення суду; апеляційної скарги на судовий наказ, заяви про перегляд судового рішення у зв’язку з нововиявленими обставинами", "7) касаційної скарги на рішення суду; заяви про приєднання до касаційної скарги на рішення суду", "8) заяви про перегляд судових рішень Верховним Судом України"], ["юридичною особою або фізичною особою - підприємцем", "фізичною особою"]]),
         SecondTable(section: ["За подання до господарського суду:"], objects: [["1) позовної заяви майнового характеру", "2) позовної заяви немайнового характеру", "3) заяви про вжиття запобіжних заходів та забезпечення позову; заяви про видачу виконавчого документа на підставі рішення іноземного суду; заяви про скасування рішення третейського суду; заяви про видачу виконавчого документа на примусове виконання рішення третейського суду; заяви про роз’яснення судового рішення", "4) апеляційної скарги на рішення суду; апеляційних скарг у справі про банкрутство; заяви про перегляд судового рішення у зв’язку з нововиявленими обставинами", "5) касаційної скарги на рішення суду; касаційних скарг у справі про банкрутство", "6) заяви про перегляд судових рішень Верховним Судом України", "7) апеляційної і касаційної скарги на ухвалу суду; заяви про приєднання до апеляційної чи касаційної скарги на ухвалу суду", "8) заяви про затвердження плану санації до порушення провадження у справі про банкрутство", "9) заяви про порушення справи про банкрутство", "10) заяви кредиторів, які звертаються з грошовими вимогами до боржника після оголошення про порушення справи про банкрутство, а також після повідомлення про визнання боржника банкрутом; заяви про визнання правочинів (договорів) недійсними та спростування майнових дій боржника в межах провадження у справі про банкрутство; заяви про розірвання мирової угоди, укладеної у справі про банкрутство, або визнання її недійсною"]]),
         SecondTable(section: ["За подання до адміністративного суду:", "1) адміністративного позову майнового характеру, який подано:", "адміністративного позову немайнового характеру, який подано:"], objects: [[],["суб’єктом владних повноважень, юридичною особою", "фізичною особою або фізичною особою - підприємцем"], ["суб’єктом владних повноважень, юридичною особою або фізичною особою - підприємцем", "фізичною особою", "2) апеляційної скарги на рішення суду, заяви про приєднання до апеляційної скарги на рішення суду, заяви про перегляд судового рішення у зв’язку з нововиявленими обставинами", "3) касаційної скарги на рішення суду, заяви про приєднання до касаційної скарги на рішення суду", "4) заяви про перегляд судового рішення Верховним Судом України", "5) апеляційної і касаційної скарги на ухвалу суду; заяви про приєднання до апеляційної чи касаційної скарги на ухвалу суду", "6) заяви про забезпечення доказів або позову, заяви про видачу виконавчого документа на підставі рішення іноземного суду, заяви про зміну чи встановлення способу, порядку і строку виконання судового рішення"]]),
         SecondTable(section: ["За видачу судами документів:"], objects: [["1) за повторну видачу копії судового рішення", "2) за видачу дубліката судового наказу та виконавчого листа", "3) за роздрукування технічного запису судового засідання", "4) за видачу в електронному вигляді копії технічного запису судового засідання", "5) за виготовлення копії судового рішення у разі, якщо особа, яка не бере (не брала) участі у справі, якщо судове рішення безпосередньо стосується її прав, свобод, інтересів чи обов’язків, звертається до апарату відповідного суду з письмовою заявою про виготовлення такої копії згідно із Законом України 'Про доступ до судових рішень'", "6) за виготовлення копій документів, долучених до справи"]]),
         SecondTable(section: [" "], objects: [["У разі ухвалення судом постанови про накладення адміністративного стягнення"]])]
    
    
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
     
    }

    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return firstTableArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firstTableArray[section].objects.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CellClass
        
        cell.labelCell?.text = firstTableArray[indexPath.section].objects[indexPath.row]
        cell.labelCell?.textColor = UIColor(white: 1.0, alpha: 1.0)
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return firstTableArray[section].section
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath: NSIndexPath = self.tableView.indexPathForSelectedRow! as NSIndexPath
        
        let destViewController = segue.destination as! SecondTableViewController
        //парсим массив на структуры, индекс элемента массива - номер выбранной строки
        var secondTableArrayTwo: SecondTable
        secondTableArrayTwo = secondArray[indexPath.row]
        
        //парсим саму структуру на пропертиз
        destViewController.sections = secondTableArrayTwo.section
        destViewController.objects = secondTableArrayTwo.objects
    }
    



}

