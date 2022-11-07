//
//  Mode.swift
//  7OzPlanet
//
//  Created by Artemius on 28.04.2022.
//

import Foundation

class Mode {
    
    static let shared = Mode()
    
    var mode: String {
        get {
            return UserDefaults.standard.string(forKey: "mode")!
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "mode")
        }
    }
    
    var isDarkMode : Bool {
        if mode == "dark" {
            return true
        } else {
            return false
        }
    }
    
    init() {
        UserDefaults.standard.register(defaults: ["mode" : "light"])
    }
}
