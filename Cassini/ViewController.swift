//
//  ViewController.swift
//  Cassini
//
//  Created by Ingenieria y Software on 22/10/15.
//  Copyright © 2015 Ingenieria y Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("identifier == \(segue.identifier)")
        if let ivc = segue.destinationViewController as? ImageViewController
        {
            if let identifier = segue.identifier
            {
                switch identifier{
                    case "earth":
                        ivc.imageURL = DemoURL.NASA.Earth
                        ivc.title = "Earth"
                    case "cassini":
                        ivc.imageURL = DemoURL.NASA.Cassini
                        ivc.title = "Cassini"
                    case "saturn":
                        ivc.imageURL = DemoURL.NASA.Saturn
                        ivc.title = "Saturn"
                default:
                    ivc.imageURL = DemoURL.Stanford
                    ivc.title = "Stanford"
                }
            }
        }
    }
}
