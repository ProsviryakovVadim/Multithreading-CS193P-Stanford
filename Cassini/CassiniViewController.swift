//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Vadim on 09.07.16.
//  Copyright © 2016 Vadim Prosviryakov. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController, UISplitViewControllerDelegate {

    private struct Storyboard {
        static let ShowImageSegue = "Show image"
    }
    
    @IBAction func showImage(sender: AnyObject) {
        if let ivc = splitViewController?.viewControllers.last?.contentViewController as? ImageViewController {
            let imageName = (sender as? UIButton)?.currentTitle 
                ivc.imageURL = DemoURL.NASAImageNamed(imageName)
                ivc.title = imageName
        } else {
            performSegueWithIdentifier(Storyboard.ShowImageSegue, sender: sender)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        splitViewController?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {
        if primaryViewController.contentViewController == self {
            if let ivc = secondaryViewController.contentViewController as? ImageViewController where ivc.imageURL == nil  {
                return true
            }
        }
        return false
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == Storyboard.ShowImageSegue {
            if let ivc = segue.destinationViewController.contentViewController as? ImageViewController {
                if let imageName = (sender as? UIButton)?.currentTitle {
                    ivc.imageURL = DemoURL.NASAImageNamed(imageName)
                    ivc.title = imageName
                }
            }
        }
    }
}

extension UIViewController {
    
    var contentViewController: UIViewController {
        
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        } else {
            return self
        }
    }
}