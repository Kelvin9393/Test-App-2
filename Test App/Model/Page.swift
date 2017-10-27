//
//  Page.swift
//  Test App
//
//  Created by KELVIN LING SHENG SIANG on 27/10/2017.
//  Copyright © 2017 KELVIN LING SHENG SIANG. All rights reserved.
//

import Foundation
import GameplayKit

class Page {
    private var _letter: String!
    private var _webViewColor = UIColor(red: .random(),
                                        green: .random(),
                                        blue: .random(),
                                        alpha: 1)
    private var _labelColor = UIColor(red: .random(),
                                      green: .random(),
                                      blue: .random(),
                                      alpha: 1)
    
    var letter: String {
        if _letter == nil {
            return ""
        }
        return _letter
    }
    
    var webViewColor: UIColor {
        return _webViewColor
    }
    
    var labelColor: UIColor {
        return _labelColor
    }
    
    init() {
        setLetter()
        _webViewColor = UIColor(red: .random(),
                                green: .random(),
                                blue: .random(),
                                alpha: 1)
        _labelColor = UIColor(red: .random(),
                              green: .random(),
                              blue: .random(),
                              alpha: 1)
    }
    
    func setLetter() {
        var alphabets = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        alphabets = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: alphabets) as! [String]
        _letter = alphabets[0]
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
