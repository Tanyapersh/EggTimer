

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTime = ["Soft" : 320, "Medium" : 420, "Hard" : 700]
    var totalTime = 0
    var secondPassed = 0
    var timer = Timer()
    var player: AVAudioPlayer?
    
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var label: UILabel!
    
    
    

    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        progress.progress = 1.0
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTime[hardness]!
        
        progress.progress = 0.0
        secondPassed = 0
        label.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        }
    
    @objc   func updateTimer () {
        
        if secondPassed <= totalTime {
            
            let procentageProgress = Float(secondPassed) / Float(totalTime)
            progress.progress = procentageProgress
            secondPassed += 1
         }
        else {
            timer.invalidate()
            label.text = "DONE"
            playSound()
        }
    }
    
    
        func playSound() {
            guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)

                /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

                /* iOS 10 and earlier require the following line:
                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

                guard let player = player else { return }

                player.play()

            } catch let error {
                print(error.localizedDescription)
            }
}


}
