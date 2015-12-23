//
//  SetCardView.swift
//  Matchismo
//
//  Created by Davis Koh on 12/22/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

import UIKit

class SetCardView: CardView {
    func drawTriangle() {

    }

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)

        if self.faceUp {
            switch self.suit {
            case "triangle":
                break
            case "oval":
                break
            case "squiggle":
                break
            default:
                break
            }
        }
    }
}
