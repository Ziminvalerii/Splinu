//
//  WateringCanTheme.swift
//  JuiceFactory
//
//  Created by Artemius on 01.08.2022.
//

import UIKit
import Foundation

public enum WateringCanNames: String {
    case can1
    case can2
    case can3
    case can4
}

class WateringCanTheme {
    
    static let shared = WateringCanTheme()
    
    private var canLevelKey = "canLevel"
    
    var currentCan: String {
        switch canLevel {
        case 2:
            return WateringCanNames.can2.rawValue
        case 3:
            return WateringCanNames.can3.rawValue
        case 4:
            return WateringCanNames.can4.rawValue
        default:
            return WateringCanNames.can1.rawValue
        }
    }
    
    var canToBuy: String {
        switch canLevel {
        case 1:
            return WateringCanNames.can2.rawValue
        case 2:
            return WateringCanNames.can3.rawValue
        default:
            return WateringCanNames.can4.rawValue
        }
    }
    
    var canLevel: Int {
        get {
            return UserDefaults.standard.integer(forKey: canLevelKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: canLevelKey)
        }
    }
    
    var canPrice: Int {
        var basePrice: Int = 500
        switch canLevel {
        case 1:
            basePrice = 1000
        case 2:
            basePrice = 1500
        case 3:
            basePrice = 5000
        default:
            break
        }
        
        return basePrice
    }
    
    var tapsToWaterTree: Int {
        return 10 - canLevel
    }
    
    func increaseCanLevel() {
        guard canLevel < 4 else { return }
        self.canLevel += 1
    }
    
    init() {
        UserDefaults.standard.register(defaults: [canLevelKey: 1])
    }
}
