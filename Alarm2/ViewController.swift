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
   
   
   @IBOutlet weak var stopButton: UIButton!
   
   var soundEnable = true
   var audioPlayer: AVAudioPlayer?
   
   override func viewDidLoad() {
      super.viewDidLoad()

      stopButton.isHidden = true
      playMusic()
      currentDate()
   }
   
   func currentDate() {
      let currentDate = Date()
      let calendar = Calendar.current
      let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate)
      print(diffDateComponents.hour)
      if diffDateComponents.hour == 4 {
         audioPlayer?.volume = 1
         stopButton.isHidden = false
      } else if diffDateComponents.hour == 11 {
         audioPlayer?.volume = 1
         stopButton.isHidden = false
      } else if diffDateComponents.hour == 12 {
         audioPlayer?.volume = 1
         stopButton.isHidden = false
      }
   }
   
   func playMusic() {
      
      let alertSound = URL(fileURLWithPath: Bundle.main.path(forResource: "3136", ofType: "wav")!)
      try! AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: .default, options: .defaultToSpeaker)
      try! AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
      try! audioPlayer = AVAudioPlayer(contentsOf: alertSound)
      audioPlayer?.volume = 0
      audioPlayer?.numberOfLoops = 1000000000000000
      audioPlayer?.prepareToPlay()
      audioPlayer?.play()
   }
   
   @IBAction func stopAction(_ sender: Any) {
      audioPlayer?.volume = 0
      stopButton.isHidden = true
   }
   

}

