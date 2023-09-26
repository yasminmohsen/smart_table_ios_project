//
//  Extension String.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 23/03/2021.
//

import Foundation


extension String {
    var localized : String{
        return NSLocalizedString(self, comment: "")
    }
}

extension String {
    var decodingUnicodeCharacters: String { applyingTransform(.init("Hex-Any"), reverse: false) ?? "" }
}
