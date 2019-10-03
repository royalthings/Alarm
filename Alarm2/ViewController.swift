import UIKit
import AVFoundation

class ViewController: UIViewController {
   
   @IBOutlet weak var stopButton: UIButton!
   
   fileprivate var timer = Timer()
   fileprivate var soundEnable = false
   fileprivate var audioPlayer: AVAudioPlayer?
   fileprivate var timeInterval: TimeInterval?
   fileprivate var resource = "Audio.wav"
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      stopButton.isHidden = true
      
      DispatchQueue.main.async {
         self.playSound(resource: self.resource)
      }
      
      startTimer(alarmTime(hour: 10, minute: 0, second: 0))
      
      //let notificationCenter = NotificationCenter.default
      //notificationCenter.addObserver(self, selector: #selector(handleInterruption), name: AVAudioSession.interruptionNotification, object: nil)
   }
   
//   @objc func handleInterruption(notification: Notification) {
//       guard let userInfo = notification.userInfo,
//           let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
//           let type = AVAudioSession.InterruptionType(rawValue: typeValue) else {
//               return
//       }
//
//       if type == .began {
//           print("Interruption began")
//           // Interruption began, take appropriate actions
//       }
//       else if type == .ended {
//           if let optionsValue = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt {
//               let options = AVAudioSession.InterruptionOptions(rawValue: optionsValue)
//               if options.contains(.shouldResume) {
//                   // Interruption Ended - playback should resume
//                   print("Interruption Ended - playback should resume")
//                   playSound(resource: resource)
//               } else {
//                   // Interruption Ended - playback should NOT resume
//                   print("Interruption Ended - playback should NOT resume")
//               }
//           }
//       }
//   }
   
   //MARK: - Restart audioPlayer
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      audioPlayer?.stop()
      audioPlayer?.play()
   }
   
   //MARK: - Delay time calculation
   fileprivate func alarmTime(hour: Int, minute: Int, second: Int) -> TimeInterval {
      let nowDate = Date()
      let calendar = Calendar.current
      let components = DateComponents(calendar: calendar, hour: hour, minute: minute, second: second)
      let nextTime = calendar.nextDate(after: nowDate, matching: components, matchingPolicy: .nextTime)!
      timeInterval = nextTime.timeIntervalSinceNow
      return timeInterval!
   }
   
   //MARK: - AudioPlayer volume = 1 after delay
   fileprivate func startTimer(_ alarmTime: TimeInterval) {
      timer.invalidate()
      timer = Timer.scheduledTimer(withTimeInterval: alarmTime, repeats: true, block: { _ in
         self.audioPlayer?.currentTime = 0
         self.audioPlayer?.volume = 1
         self.stopButton.isHidden = false
         self.recalculeteTime()
      })
   }
   
   //MARK: - Recalculete Time
   fileprivate func recalculeteTime()  {
      let date = Date()
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "HH:mm:ss"
      let now = dateFormatter.string(from: date)
      let calendar = Calendar.current
      if now == "10:00:00" {
         let components = DateComponents(calendar: calendar, hour: 11, minute: 0, second: 0)
         let nextTime = calendar.nextDate(after: date, matching: components, matchingPolicy: .nextTime)!
         timeInterval = nextTime.timeIntervalSinceNow
         startTimer(timeInterval!)
      }
      if now == "11:00:00" {
         let components = DateComponents(calendar: calendar, hour: 12, minute: 0, second: 0)
         let nextTime = calendar.nextDate(after: date, matching: components, matchingPolicy: .nextTime)!
         timeInterval = nextTime.timeIntervalSinceNow
         startTimer(timeInterval!)
      }
      if now == "12:00:00" {
         let components = DateComponents(calendar: calendar, hour: 10, minute: 0, second: 0)
         let nextTime = calendar.nextDate(after: date, matching: components, matchingPolicy: .nextTime)!
         timeInterval = nextTime.timeIntervalSinceNow
         startTimer(timeInterval!)
      }
   }
   
   //MARK: - Play sound
   fileprivate func playSound(resource: String) {
      let path = Bundle.main.path(forResource: resource, ofType: nil)!
      let url = URL(fileURLWithPath: path)
      do {
         audioPlayer = try AVAudioPlayer(contentsOf: url)
         audioPlayer?.volume = 0
         audioPlayer?.numberOfLoops = -1
         audioPlayer?.delegate = self
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

//MARK: - AudioPlayer Delegate
extension ViewController: AVAudioPlayerDelegate {
   
   func audioPlayerEndInterruption(_ player: AVAudioPlayer, withOptions flags: Int) {
      playSound(resource: resource)
   }
}
