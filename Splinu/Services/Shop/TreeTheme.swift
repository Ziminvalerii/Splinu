//
//  WaterPipe.swift
//  PlatinumPlay
//
//  Created by Artemius on 04.05.2022.
//

import UIKit
import Foundation

public enum TreesNames: String {
    case appleTree
    case orangeTree
    case grapefruitTree
    case pearTree
}

public enum TreesSize: String {
    case smallTree
    case middleTree
    case bigTree
}

class TreeTheme {
    
    static let shared = TreeTheme()
    
    private var treeLevelKey = "treeLevel"
    
    var currentTree: String {
        switch treeLevel {
        case 2:
            return TreesSize.middleTree.rawValue
        case 3:
            return TreesSize.bigTree.rawValue
        default:
            return TreesSize.smallTree.rawValue
        }
    }
    
    var treeToBuy: String {
        switch treeLevel {
        case 1:
            return TreesSize.middleTree.rawValue
        default:
            return TreesSize.bigTree.rawValue
        }
    }
    
    var treeLevel: Int {
        get {
            return UserDefaults.standard.integer(forKey: treeLevelKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: treeLevelKey)
        }
    }
    
    var treePrice: Int {
        var basePrice: Int = 500
        switch treeLevel {
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
    
    var treeFruitsCount: Int {
        return 3 + treeLevel * 2
    }
    
    func increaseTreeLevel() {
        guard treeLevel < 3 else { return }
        self.treeLevel += 1
    }
    
    
    init() {
        UserDefaults.standard.register(defaults: [treeLevelKey: 1])
    }
}
