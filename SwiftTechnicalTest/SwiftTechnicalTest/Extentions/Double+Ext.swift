//
//  Double+Ext.swift
//  SwiftTechnicalTest
//
//  Created by GEORGE QUENTIN on 17/05/2019.
//  Copyright © 2019 GEORGE QUENTIN. All rights reserved.
//

import UIKit

public extension Double {
    var toCurrency: String {
        return String(format: "%.02f", self)
    }
}
