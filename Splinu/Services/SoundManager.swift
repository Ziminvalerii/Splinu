//
//  SoundManager.swift
//  Vertical Fluppy Bird
//
//  Created by Artemius on 17.01.2022.
//

import SpriteKit
import AVFoundation

class SoundManager {
    static let shared = SoundManager()
    var player = AVAudioPlayer()
    var soundPlayer = AVAudioPlayer()
    
    func playBackgroundMusic() {
        let path = Bundle.main.path(forResource: "backgroundMusic.wav", ofType: nil)!
        let url = URL(fileURLWithPath: path)
        do {
            self.player = try AVAudioPlayer(contentsOf: url)
            self.player.numberOfLoops = -1
            self.player.volume = 0.1
            self.player.play()
        } catch {
            print("no sound")
        }
    }
    
    func playSound() {
        let path = Bundle.main.path(forResource: "waterDrop1.wav", ofType: nil)!
        let url = URL(fileURLWithPath: path)
        do {
            self.soundPlayer = try AVAudioPlayer(contentsOf: url)
            self.soundPlayer.volume = 0.2
            self.soundPlayer.play()
        } catch {
            print("no sound")
        }
    }
    
    
    func stopMusic() {
        player.stop()
    }
}
