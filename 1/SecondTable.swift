import Foundation

struct SecondTable {
    var section: [String]
    var objects: [[String]]
    
    init(section: [String], objects: [[String]]) {
        self.section = section
        self.objects = objects
    }
}
