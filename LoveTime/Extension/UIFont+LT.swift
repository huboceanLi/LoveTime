//
//  UIFont+LT.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/13.
//

import Foundation

extension UIFont {
    
    @objc static func lt_ZhenyanGBFont(ofSize fontSize: CGFloat) -> UIFont? {
        //let font = UIFont.init(name: "Plus Jakarta Sans Bold", size: fontSize)
        let font = UIFont.init(name: "ZhenyanGB", size: fontSize)
        return font
    }
    @objc static func lt_QisimomoFont(ofSize fontSize: CGFloat) -> UIFont? {
        //let font = UIFont.init(name: "Plus Jakarta Sans SemiBold", size: fontSize)
        let font = UIFont.init(name: "Qisimomo_xinjian", size: fontSize)
        return font
    }
}
