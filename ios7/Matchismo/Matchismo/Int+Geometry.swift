//
//  Int+Geometry.swift
//  Matchismo
//
//  Created by Davis Koh on 12/23/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

import Foundation

extension Int {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * CGFloat(M_PI) / 180.0
    }
}