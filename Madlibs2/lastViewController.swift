//
//  lastViewController.swift
//  Madlibs2
//
//  Created by Swift on 3/15/16.
//  Copyright © 2016 Swift. All rights reserved.
//

import UIKit

class lastViewController: UIViewController {
    @IBOutlet weak var showTextLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    var receiver1 = String()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        textLabel.text = receiver1
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
