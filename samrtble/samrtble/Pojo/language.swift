//
//  language.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 23/03/2021.
//

import Foundation
import MOLH

enum Language {
    case arabic
    case english
    case non
}

class LanguageOperation {
    static func checkLanguage() -> Language {
        let preferredLanguage = MOLHLanguage.currentAppleLanguage()
        if preferredLanguage == "en" {
            return.english
        } else if preferredLanguage == "ar" {
            return.arabic
        }
        return .non
    }
}

