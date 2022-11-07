//
//  Theme.swift
//  Vertical Fluppy Bird
//
//  Created by Artemius on 18.01.2022.
//

import Foundation
import UIKit

public enum BottleNames: String {
    case bottle1
    case bottle2
    case bottle3
}

class BottleTheme {
    
    static let shared = BottleTheme()
    
    private var bottleKey = "bottle"
    private var bottleLevelKey = "bottleLevel"
    
    var currentBottle: String {
        switch bottleLevel {
        case 1:
            return BottleNames.bottle1.rawValue
        case 2:
            return BottleNames.bottle2.rawValue
        default:
            return BottleNames.bottle3.rawValue
        }
    }
    
    var bottleToBuy: String {
        switch bottleLevel {
        case 1:
            return BottleNames.bottle2.rawValue
        default:
            return BottleNames.bottle3.rawValue
        }
    }
    
    var bottleLevel: Int {
        get {
            return UserDefaults.standard.integer(forKey: bottleLevelKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: bottleLevelKey)
        }
    }
    
    var bottlePrice: Int {
        var basePrice: Int = 5
        switch currentBottle {
        case "bottle1":
            basePrice = 100
        case "bottle2":
            basePrice = 500
        case "bottle3":
            basePrice = 1500
        default:
            break
        }
        return basePrice
    }
    
    var bottleReward: Int {
        return 5 +  bottleLevel * 5
    }
    
    func increaseBottleLevel() {
        guard bottleLevel < 3 else { return }
        self.bottleLevel += 1
    }
    
    init() {
        UserDefaults.standard.register(defaults: [bottleKey : "bottle1", bottleLevelKey: 1])
    }
}
