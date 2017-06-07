//
//  SectionStruct.swift
//  Fees
//
//  Created by Anna on 04.06.17.
//  Copyright © 2017 Anna. All rights reserved.
//


import Foundation

struct Section {
    var section: String
    var objects: [String]
    
    init(section: String, objects: [String]) {
        self.section = section
        self.objects = objects
    }
}
