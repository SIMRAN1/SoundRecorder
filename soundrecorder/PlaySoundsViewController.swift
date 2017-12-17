//
//  PlaySoundsViewController.swift
//  soundrecorder
//
//  Created by SIMRANPREET KAUR on 17/12/17.
//  Copyright © 2017 SIMRANPREET KAUR. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    var audioPlayer : AVAudioPlayer!
    var recievedAudio: RecordedAudio!
    
    var audioEngine : AVAudioEngine!
    var audioFile:AVAudioFile!
    override func viewDidLoad() {
        super.viewDidLoad()
     /* if var filePath = Bundle.main.path(forResource: "sound", ofType:"mp3")
      {var filePathUrl = NSURL.fileURL(withPath: filePath)
        
        
       }
      else
      {print("File not Found")
        }*/
        // Do any additional setup after loading the view.
        do{
            audioPlayer = try AVAudioPlayer.init(contentsOf: recievedAudio.filePathUrl as URL)
            audioPlayer.enableRate = true
            audioEngine = AVAudioEngine()
            audioFile = try AVAudioFile.init(forReading: recievedAudio.filePathUrl as URL)
        }catch {
            print("file not fund")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSoundDragon(_ sender: UIButton) {
         playAudioWithVariablePitch(pitch: -1000)
    }
    
    @IBAction func playChipMunk(_ sender: UIButton) {
        playAudioWithVariablePitch(pitch: 1000)
    }
    func playAudioWithVariablePitch(pitch: Float)
    {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attach(audioPlayerNode)
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attach(changePitchEffect)
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile, at: nil, completionHandler: nil)
        do
        {
         try    audioEngine.start()
            audioPlayerNode.play()
        }catch
        {
            print("error while playing")
        }
        
    }
    @IBAction func playFastFound(_ sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 1.5
        audioPlayer.currentTime=0.0
        audioPlayer.play()
    }
    @IBAction func playSoundSlow(_ sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        audioPlayer.currentTime=0.0
        audioPlayer.play()
        print("sound slowly played")
        
    }
    
    
    @IBAction func StopSound(_ sender: UIButton) {
        audioPlayer.stop()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
