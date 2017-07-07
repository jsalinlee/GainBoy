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
            let fontName = newValue
            let fontSize = self.font.pointSize
            self.font = UIFont(name: fontName, size: fontSize)
        }
    }
}

extension UITextView {
    public var substituteFontName: String {
        get {
            return self.font?.fontName ?? ""
        }
        set {
            let fontName = newValue
            let fontSize = (self.font?.pointSize)!
            self.font = UIFont(name: fontName, size: fontSize)
        }
    }
}

extension UITextField {
    public var substituteFontName: String {
        get {
            return self.font?.fontName ?? ""
        }
        set {
            let fontName = newValue
            let fontSize = (self.font?.pointSize)!
            self.font = UIFont(name: fontName, size: fontSize)
        }
    }
}
