//
//  ViewController.swift
//  Alarm2
//
//  Created by Дмитрий Ага on 9/22/19.
//  Copyright © 2019 Дмитрий Ага. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
   
   var timer: Timer?
   @IBOutlet weak var stopButton: UIButton!
   
   var releaseDate: Date?
   var countdownTimer = Timer()
   
   var soundEnable = true
   var audioPlayer: AVAudioPlayer?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      stopButton.isHidden = true
      //playMusic()
      
      playSound(resource: "3136.wav")
      
      startTimer()

   }
   
   func startTimer() {
      timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
      
   }
   
   @objc func updateTime() {
      
      let currentTime = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium)
      print(currentTime)
      
      
      if currentTime == "10:00:00 AM" || currentTime == "11:19:00 AM" || currentTime == "12:00:00 AM" {
         audioPlayer?.volume = 1
         stopButton.isHidden = false
      }
   }
   
   
   func playSound(resource: String) {
      let path = Bundle.main.path(forResource: resource, ofType: nil)!
      let url = URL(fileURLWithPath: path)
      
      do {
         audioPlayer = try AVAudioPlayer(contentsOf: url)
         audioPlayer?.volume = 0
         audioPlayer?.numberOfLoops = -1
         audioPlayer?.prepareToPlay()
         audioPlayer?.play()
      } catch {
         // couldn't load file :(
      }
   }

//   func playMusic() {
//      let alertSound = URL(fileURLWithPath: Bundle.main.path(forResource: "3136", ofType: "wav")!)
//      try! AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: .default, options: .defaultToSpeaker)
//      try! AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
//      try! audioPlayer = AVAudioPlayer(contentsOf: alertSound)
//      audioPlayer?.volume = 0
//      audioPlayer?.numberOfLoops = -1
//      audioPlayer?.prepareToPlay()
//      audioPlayer?.play()
//   }
   
   @IBAction func stopAction(_ sender: Any) {
      audioPlayer?.volume = 0
      stopButton.isHidden = true
   }
}

