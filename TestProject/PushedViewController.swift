//
//  PushedViewController.swift
//  TestProject
//
//  Created by Quang Minh Trinh on 11/25/17.
//  Copyright © 2017 Quang Minh Trinh. All rights reserved.
//

import UIKit

class PushedViewController: UIViewController {

    // MARK: - Properties
    var customLabel: UILabel!
    var testObject: TestObject!
    var initedString: String!
    var updatedTimes: Int = 1
    private var customBlock : (()->())!
    private var customBlockTimer: Timer?
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // init custom label with text "Test"
        addCustomLabel()
        
        /*
         // Uncomment this and comment the customBlock below, if you write like this, it will not deinit, never! Because the closure still hold strong reference to self
         customBlock = {
            self.initedString = "Custom"
         }
        */
        
        // Change inheritedString to Custom
        
        customBlock = { [weak self] in
            if let selfVC = self {
                selfVC.initedString = "Custom"
            }
        }
        // call the customBlock to execute
        customBlock()
        customLabel.text = initedString
        /*
         // Uncomment this and comment the startWeakTimer velow, if you write like this, the view controller will be deinit but you will see a crash! Because the timer block is still not deallocated
         // meanwhile the self view controller has been dealloc
         // the unowned self is used as a reference if we are sure that self controller have lifetime longer that the execution of the timer
         startTimerWithUnownedSelf()
        */
        
        startTimerWithWeakSelf()
    }
    deinit {
        // check if view controller has been "really" deinit
        print ("Pushed View Controller has been deinitalized")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    // MARK: - Methods
    func addCustomLabel() {
        customLabel = UILabel.init()
        customLabel.text = "Test"
        view.addSubview(customLabel)
        customLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [NSLayoutConstraint.init(item: customLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
                                                 NSLayoutConstraint.init(item: customLabel, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)]
        view.addConstraints(constraints)
    }
    func makeCustomUnownedBlock() {
        customBlock = { [unowned self] in
            self.initedString = "Updated no \(self.updatedTimes)"
            self.customLabel.text = self.initedString
            self.updatedTimes += 1
        }
        customBlock()
    }
    
    func startTimerWithUnownedSelf () {
        customBlockTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: {[unowned self] (timer) in
            // The advantage of unowned is because we can make sure the lifetime of block execution is shorter that self, we don't need to wrap self as optional. In addition, it is like weak ref, which
            // means it allow the self view controller to dealloc right the time its object reference set to nil (pop view controller)
            self.makeCustomUnownedBlock()
            
        })
        customBlockTimer?.fire()
    }
    
    func startTimerWithWeakSelf() {
        customBlockTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: {[weak self] (timer) in
            if let selfVC = self {
                selfVC.makeCustomUnownedBlock()
            }
        })
        customBlockTimer?.fire()
    }
}
