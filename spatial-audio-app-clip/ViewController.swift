//
//  ViewController.swift
//  spatial-audio-app-clip
//
//  Created by Alden Braverman on 11/11/21.
//

import UIKit
import CoreMotion

var degreesYaw = 0.0
var degreesPitch = 0.0
var degreesRoll = 0.0

var yawEnabled = true
var pitchEnabled = false
var rollEnabled = false

class ViewController: UITableViewController, CMHeadphoneMotionManagerDelegate {
    
    @IBOutlet var pitchValue: UILabel!
    @IBOutlet var rollValue: UILabel!
    @IBOutlet var yawValue: UILabel!

    @IBAction func enablePitch(_ sender: Any) {
        pitchEnabled = !pitchEnabled
        if(!pitchEnabled){
            degreesPitch = 0
        }
    }
    @IBAction func enableRoll(_ sender: Any) {
        rollEnabled = !rollEnabled
        if(!rollEnabled){
            degreesRoll = 0
        }
    }
    @IBAction func enableYaw(_ sender: Any) {
        yawEnabled = !yawEnabled
        if(!yawEnabled){
            degreesYaw = 0
        }
    }
    
    var motionManager: CMHeadphoneMotionManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        motionManager = CMHeadphoneMotionManager()
        motionManager.delegate = self
        if motionManager.isDeviceMotionAvailable {
            motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { (motion, error) in
                
                if (yawEnabled){
                    degreesYaw = -(motion?.attitude.yaw)! * 180 / Double.pi
                } else {
                    degreesYaw = 0;
                }
                if (pitchEnabled){
                    degreesPitch = (motion?.attitude.pitch)! * 180 / Double.pi
                } else {
                    degreesPitch = 0;
                }
                if (rollEnabled){
                    degreesRoll = (motion?.attitude.roll)! * 180 / Double.pi
                } else {
                    degreesRoll = 0;
                }
                
                self.yawValue.text = "\(degreesYaw)"
                self.pitchValue.text = "\(degreesPitch)"
                self.rollValue.text = "\(degreesRoll)"
            }
        }
    }
}
