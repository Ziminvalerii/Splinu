//
//  StartViewController.swift
//  Vertical Fluppy Bird
//
//  Created by Dr.Drexa on 23.12.2021.
//

import UIKit

class StartViewController: BaseVC {
     var isMusicOn = true

    @IBOutlet weak var soundButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SoundManager.shared.playBackgroundMusic()
    }
    
    @IBAction func soundButtonTapped(_ sender: Any) {
        isMusicOn = !isMusicOn
        !isMusicOn ? SoundManager.shared.stopMusic() : SoundManager.shared.playBackgroundMusic()
        let imageName = isMusicOn ? "soundOnButton" : "soundOffButton"
        let image = UIImage(named: imageName)
        soundButton.setImage(image, for: .normal)
    }
    @IBAction func privacyPolicyButtonPressed(_ sender: Any) {
        guard let url = URL(string: "https://docs.google.com/document/d/140sgfS3PQ_AU2KBaEuZC52LA9QLg27Gwl5Lq3BKq9xA/edit?usp=sharing") else { return }
        let vc = PrivacyPolicyViewController(url: url)
        vc.modalPresentationStyle = .formSheet
        self.present(vc, animated: true)
    }
    
}
