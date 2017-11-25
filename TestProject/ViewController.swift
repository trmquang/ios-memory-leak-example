//
//  ViewController.swift
//  TestProject
//
//  Created by Quang Minh Trinh on 11/25/17.
//  Copyright © 2017 Quang Minh Trinh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    private let testObject = TestObject()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - IBActions
    @IBAction func pushBtn_TouchUpInside(_ sender: Any) {
        let storyBoard = UIStoryboard.init(name: "Pushed", bundle: Bundle.main)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "PushedViewController") as? PushedViewController {
            vc.initedString = "wtf"
            vc.testObject = testObject
            if let navigationController = navigationController {
                navigationController.pushViewController(vc, animated: true)
            }
        }
        
    }
    
}

