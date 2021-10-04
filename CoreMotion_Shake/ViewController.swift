//
//  ViewController.swift
//  CoreMotion_Shake
//
//  Created by fyz on 7/8/18.
//  Copyright © 2018 Feyza Topgul. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    var manager: CMMotionManager!
    var control = false
    var delta = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.green
        
        manager = CMMotionManager()
        if manager.isDeviceMotionAvailable {
            manager.deviceMotionUpdateInterval = 1.0 / 60.0
            let queue = OperationQueue.main
            manager.startDeviceMotionUpdates(to: queue, withHandler: { (data, error) in
                if let values = data {
                    let today = Date()
                    let seconds = today.timeIntervalSince(self.delta)
                    let acc = values.userAcceleration.x
                    if seconds > 0.5 && acc > 2.0 {
                        self.delta = today
                        if self.control {
                            self.view.backgroundColor = UIColor.yellow
                            self.control = false
                        } else {
                            self.view.backgroundColor = UIColor.green
                            self.control = true
                        }
                    }
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

