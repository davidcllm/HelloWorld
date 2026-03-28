//
//  ProfileViewController.swift
//  HelloWorld
//
//  Created by Alumnos on 27/03/26.
//

import UIKit
import AVKit
import AVFoundation

class ProfileViewController: UIViewController {
    var player: AVPlayer? // Reproductor de música
    
    // MARK: - DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let helpButton = UIBarButtonItem(title: "Help", style: .plain, target: self, action: #selector(didTapHelp))
        
        let audioButton = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(didTapAudio))
        audioButton.tintColor = .green
        
        let stopButton = UIBarButtonItem(barButtonSystemItem: .pause, target: self, action: #selector(didTapStop))
        stopButton.tintColor = .red
        
        navigationItem.rightBarButtonItems = [helpButton]
        navigationItem.leftBarButtonItems = [stopButton, audioButton]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        didTapStop()
    }
    
    @objc func didTapHelp() {
        didTapStop()
        let videoURLString = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
        
        guard let videoURL = URL(string: videoURLString) else {
            print("Invalid video URL")
            return
        }
        
        let player = AVPlayer(url: videoURL)
        
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        present(playerViewController, animated: true)
    }
    
    @objc func didTapAudio() {
        let audioURLString = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"
        
        guard let audioURL = URL(string: audioURLString) else {
            print("Invalid audio URL")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            self.player = AVPlayer(url: audioURL)
            
            guard let player = self.player else {
                print("player is nil")
                return
            }
            
            player.play()
        }
        catch {
            print(error.localizedDescription)
        }
    
    }
    
    @objc func didTapStop() {
        guard let player = self.player else {
            print("player is nil")
            return
        }
        
        player.pause()
        self.player = nil
    }
}
