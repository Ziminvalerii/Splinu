//
//  GardensData.swift
//  JuiceFactory
//
//  Created by Artemius on 09.08.2022.
//

import Foundation

class GardensData {
    
    static let shared = GardensData()
    
    var isApplesOpened: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isApplesOpened")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isApplesOpened")
        }
    }
    
    var isOrangesOpened: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isOrangesOpened")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isOrangesOpened")
        }
    }
    
    
    var isPearsOpened: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isPearsOpened")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isPearsOpened")
        }
    }
    
    var isPlumsOpened: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isPlumsOpened")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isPlumsOpened")
        }
    }
    
    init() {
        UserDefaults.standard.register(defaults: ["isApplesOpened" : true])
        UserDefaults.standard.register(defaults: ["isOrangesOpened" : false])
        UserDefaults.standard.register(defaults: ["isPearsOpened" : false])
        UserDefaults.standard.register(defaults: ["isPlumsOpened" : false])

    }
}
