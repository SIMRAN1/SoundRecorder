//
//  ViewController.swift
//  soundrecorder
//
//  Created by SIMRANPREET KAUR on 16/12/17.
//  Copyright © 2017 SIMRANPREET KAUR. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingInProgress: UILabel!
    @IBAction func stopButton(_ sender: UIButton) {
        recordingInProgress.isHidden=true
    }
    @IBOutlet weak var stopButton: UIButton!
    @IBAction func recordAudio(_ sender: UIButton) {
        //TODO: show text "recording in progress"
        recordingInProgress.isHidden=false
        stopButton.isHidden=false
        print("in record audio")
        
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


}

