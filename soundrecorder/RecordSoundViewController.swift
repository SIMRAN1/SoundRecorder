//
//  RecordSoundViewController.swift
//  soundrecorder
//
//  Created by SIMRANPREET KAUR on 16/12/17.
//  Copyright © 2017 SIMRANPREET KAUR. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController,AVAudioRecorderDelegate {

    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    var audioRecorder : AVAudioRecorder!
    var recordedAudio : RecordedAudio!
    @IBOutlet weak var stopButton: UIButton!
    let settings = [
        AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
        AVSampleRateKey: 12000,
        AVNumberOfChannelsKey: 1,
        AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
    ]

    @IBAction func stopButton(_ sender: UIButton) {
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
       do
       {
        try audioSession.setActive(false)
       }catch{
        print("exception occured")
        }
        recordingInProgress.isHidden=true
    }
   
    @IBAction func recordAudio(_ sender: UIButton) {
        //TODO: show text "recording in progress"
        recordingInProgress.isHidden=false
        stopButton.isHidden=false
        print("in record audio")
        recordButton.isEnabled = false
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        var currentDateTime = NSDate()
        var formatter = DateFormatter()
        var recordingName = formatter.string(from: currentDateTime as Date)+".wav"
        var pathArray = [dirPath,recordingName]
        let filePath = NSURL.fileURL(withPathComponents: pathArray)
        print(filePath)
        var session = AVAudioSession.sharedInstance()
        do
        {
        try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try    audioRecorder = AVAudioRecorder.init(url: filePath!, settings: settings)
               audioRecorder.delegate = self
            audioRecorder.isMeteringEnabled = true
            audioRecorder.prepareToRecord()
            audioRecorder.record()
            
            
        }catch
        {
            print("error ocurred")
        }
        
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        stopButton.isHidden=true
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag)
        {
        recordedAudio=RecordedAudio()
        recordedAudio.filePathUrl = recorder.url as NSURL
        recordedAudio.title = recorder.url.lastPathComponent
        self.performSegue(withIdentifier:"stopRecording", sender: recordedAudio)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "stopRecording")
        {
            let playSoundVC:PlaySoundsViewController = segue.destination as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundVC.recievedAudio = data
            
        }
    }

}

