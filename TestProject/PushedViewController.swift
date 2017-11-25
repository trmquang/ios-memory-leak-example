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
    private var customBlock : (()->())!
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // init custom label with text "Test"
        addCustomLabel()
        
        /*
         If you write like this, it will not deinit, never! Because the closure still hold strong reference to self
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
}
