//
//  CalculationDetails.swift
//  1
//
//  Created by Anna on 05.06.17.
//  Copyright © 2017 Anna. All rights reserved.
//

import Foundation

struct CalculationDetails {
    
    var condition: String
    var percent: Float?
    var min: Float?
    var max: Float?
    var percentOfFirstInstanceFee: Float?
    
    
    init(condition: String, percent: Float?, min: Float?, max: Float?, percentOfFirstInstanceFee: Float?) {
        self.condition = condition
        self.percent = percent
        self.min = min
        self.max = max
        self.percentOfFirstInstanceFee = percentOfFirstInstanceFee
    }

}
