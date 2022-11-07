//
//  Coins.swift
//  Vertical Fluppy Bird
//
//  Created by Artemius on 19.01.2022.
//

import Foundation

class Coins {
    
    static let shared = Coins()
    
    var coins: Int {
        get {
            return UserDefaults.standard.integer(forKey: "coins")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "coins")
        }
    }
    func addNew(coins: Int) {
        self.coins += coins
    }
    
    func decrease(coins: Int) {
        self.coins -= coins
    }
    
    init() {
        UserDefaults.standard.register(defaults: ["coins" : 0])
    }
}
