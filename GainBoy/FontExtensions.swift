//
//  FontExtensions.swift
//  GainBoy
//
//  Created by Jonathan Salin Lee on 7/6/17.
//  Copyright © 2017 Salin Studios. All rights reserved.
//

import UIKit

extension UILabel {
    public var substituteFontName: String {
        get {
            return self.font.fontName
        }
        set {
            self.font = UIFont.preferredFont(forTextStyle: .body)
            var fontName = newValue
            let fontNameToTest = self.font.fontName.lowercased()
            if fontNameToTest.range(of: "bold") != nil {
                fontName += "-Bold"
            }
            if fontNameToTest.range(of: "italic") != nil {
                fontName += "-Italic"
            }
            if fontNameToTest.range(of: "bolditalic") != nil {
                fontName += "-BoldItalic"
            }
            let fontSize = self.font.pointSize
            self.font = UIFont(name: fontName, size: fontSize)
            self.textColor = UIColor(red: 43 / 255, green: 63 / 255, blue: 106 / 255, alpha: 1)
        }
    }
}

extension UITextView {
    public var substituteFontName: String {
        get {
            return self.font?.fontName ?? ""
        }
        set {
            
            let fontNameToTest = self.font?.fontName.lowercased() ?? ""
            var fontName = newValue
            if fontNameToTest.range(of: "bold") != nil {
                fontName += "-Bold"
            }
            if fontNameToTest.range(of: "italic") != nil {
                fontName += "-Italic"
            }
            if fontNameToTest.range(of: "bolditalic") != nil {
                fontName += "-BoldItalic"
            }
            let fontSize = self.font?.pointSize ?? 17
            self.font = UIFont(name: fontName, size: fontSize)
            self.textColor = UIColor(red: 43 / 255, green: 63 / 255, blue: 106 / 255, alpha: 1)
        }
    }
}

extension UITextField {
    public var substituteFontName: String {
        get {
            return self.font?.fontName ?? ""
        }
        set {
            let fontNameToTest = self.font?.fontName.lowercased() ?? ""
            var fontName = newValue
            if fontNameToTest.range(of: "bold") != nil {
                fontName += "-Bold"
            }
            if fontNameToTest.range(of: "italic") != nil {
                fontName += "-Italic"
            }
            if fontNameToTest.range(of: "bolditalic") != nil {
                fontName += "-BoldItalic"
            }
            let fontSize = self.font?.pointSize ?? 17
            self.font = UIFont(name: fontName, size: fontSize)
            self.textColor = UIColor(red: 43 / 255, green: 63 / 255, blue: 106 / 255, alpha: 1)
        }
    }
}
