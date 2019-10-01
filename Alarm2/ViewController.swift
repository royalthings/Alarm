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

   var timer = Timer()
   var soundEnable = true
   var audioPlayer: AVAudioPlayer?
   var timeInterval: TimeInterval?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      stopButton.isHidden = true
      playSound(resource: "3136.wav")
  
      startTimer(alarmTime(hour: 10, minute: 0, second: 0))
   }
   
   //MARK: - restart audioPlayer
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      
      audioPlayer?.stop()
      audioPlayer?.play()
   }
   
   //MARK: - delay time calculation
   func alarmTime(hour: Int, minute: Int, second: Int) -> TimeInterval {
      let nowDate = Date()
      let calendar = Calendar.current
      let components = DateComponents(calendar: calendar, hour: hour, minute: minute, second: second)
      let nextTime = calendar.nextDate(after: nowDate, matching: components, matchingPolicy: .nextTime)!
      //let releaseDate = DateFormatter.localizedString(from: nextTime, dateStyle: .short, timeStyle: .medium)
      //print(releaseDate)
      timeInterval = nextTime.timeIntervalSinceNow
      //print(timeInterval!)
      return timeInterval!
   }
   
   //MARK: - audioPlayer volume = 1 after delay
   func startTimer(_ alarmTime: TimeInterval) {
      timer.invalidate()
      timer = Timer.scheduledTimer(withTimeInterval: alarmTime, repeats: true, block: { [unowned self] _ in
         self.audioPlayer?.volume = 1
         self.stopButton.isHidden = false
         self.recalculeteTime()
      })
   }
   
   func recalculeteTime()  {
      
      let date = Date()
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "HH:mm:ss"
      let now = dateFormatter.string(from: date)
      let calendar = Calendar.current
      if now == "10:00:00" {
         let components = DateComponents(calendar: calendar, hour: 11, minute: 0, second: 0)
         let nextTime = calendar.nextDate(after: date, matching: components, matchingPolicy: .nextTime)!
         timeInterval = nextTime.timeIntervalSinceNow
         //print(timeInterval!)
         startTimer(timeInterval!)
      }
      if now == "11:00:00" {
         let components = DateComponents(calendar: calendar, hour: 12, minute: 0, second: 0)
         let nextTime = calendar.nextDate(after: date, matching: components, matchingPolicy: .nextTime)!
         timeInterval = nextTime.timeIntervalSinceNow
         //print(timeInterval!)
         startTimer(timeInterval!)
      }
      if now == "12:00:00" {
         let components = DateComponents(calendar: calendar, hour: 10, minute: 0, second: 0)
         let nextTime = calendar.nextDate(after: date, matching: components, matchingPolicy: .nextTime)!
         timeInterval = nextTime.timeIntervalSinceNow
         //print(timeInterval!)
         startTimer(timeInterval!)
      }
   }

   //MARK: - play sound
   func playSound(resource: String) {
      let path = Bundle.main.path(forResource: resource, ofType: nil)!
      let url = URL(fileURLWithPath: path)
      //try! AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: .default, options: .defaultToSpeaker)
      //try! AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
      do {
         audioPlayer = try AVAudioPlayer(contentsOf: url)
         audioPlayer?.volume = 0
         audioPlayer?.numberOfLoops = -1
         audioPlayer?.prepareToPlay()
         audioPlayer?.play()
      } catch {
         print("couldn't load file")
      }
   }
   
   //MARK: - Actions
   @IBAction func stopAction(_ sender: Any) {
      audioPlayer?.volume = 0
      stopButton.isHidden = true
   }
}

