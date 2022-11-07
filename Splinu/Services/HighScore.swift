//
//  HighScore.swift
//  Vertical Fluppy Bird
//
//  Created by Artemius on 19.01.2022.
//

import Foundation

class HighScore {
    
    static let shared = HighScore()
    
    var highScore: Int {
        get {
            return UserDefaults.standard.integer(forKey: "highScore")
        }
        set {
            guard newValue < Int.max else { return }
            UserDefaults.standard.set(newValue, forKey: "highScore")
        }
    }
    
    init() {
        UserDefaults.standard.register(defaults: ["highScore" : 0])
    }
}
