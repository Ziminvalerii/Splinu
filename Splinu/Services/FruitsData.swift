//
//  FruitsData.swift
//  JuiceFactory
//
//  Created by Artemius on 08.08.2022.
//

import Foundation

class FruitsData {
    
    static let shared = FruitsData()
    
    var apples: Int {
        get {
            return UserDefaults.standard.integer(forKey: "apples")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "apples")
        }
    }
    
    var oranges: Int {
        get {
            return UserDefaults.standard.integer(forKey: "oranges")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "oranges")
        }
    }
    
    var pears: Int {
        get {
            return UserDefaults.standard.integer(forKey: "pears")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "pears")
        }
    }
    
    var plums: Int {
        get {
            return UserDefaults.standard.integer(forKey: "plums")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "plums")
        }
    }
    
    func addNew(count: Int, fruitName: String) {
        switch fruitName {
        case "apple":
            self.apples += count
        case "orange":
            self.oranges += count
        case "pear":
            self.pears += count
        case "plum":
            self.plums += count
        default:
            return
        }
    }
    
    func getCount(fruitName: String) -> Int {
        switch fruitName {
        case "apple":
           return self.apples
        case "orange":
            return self.oranges
        case "pear":
            return self.pears
        case "plum":
            return self.plums
        default:
            return 0
        }
    }
    
    func decrease(count: Int, fruitName: String) {
        switch fruitName {
        case "apple":
            self.apples -= count
        case "orange":
            self.oranges -= count
        case "pear":
            self.pears -= count
        case "plum":
            self.plums -= count
        default:
            return
        }
    }
    
    init() {
        UserDefaults.standard.register(defaults: ["apples" : 0])
        UserDefaults.standard.register(defaults: ["oranges" : 0])
        UserDefaults.standard.register(defaults: ["pears" : 0])
        UserDefaults.standard.register(defaults: ["plums" : 0])

    }
}
