//
//  CGPoint+Geometry.swift
//  Matchismo
//
//  Created by Davis Koh on 12/24/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

import Foundation

extension CGPoint {
    public func midpointTo(endpoint: CGPoint) -> CGPoint {
        return CGPoint(
            x: (self.x + endpoint.x) / 2,
            y: (self.y + endpoint.y) / 2
        )
    }
}