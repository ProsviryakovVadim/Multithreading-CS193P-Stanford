//
//  ImageViewController.swift
//  Cassini
//
//  Created by Vadim on 09.07.16.
//  Copyright © 2016 Vadim Prosviryakov. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {

    // URL
    var imageURL: NSURL? {
        didSet {
            image = nil
            if view.window != nil {
            fetchImage()
            }
        }
    }
    
    // ImageView
    private var imageView = UIImageView()
    
    // Photo
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
        }
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // ScrollView
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView?.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scrollView.addSubview(imageView)
        // imageURL = DemoURL.Stanford
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if view.window == nil {
            fetchImage()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func fetchImage() {
        if let url = imageURL {
            spinner?.startAnimating()
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)) {
                let contentsOfURL = NSData(contentsOfURL: url)
                    dispatch_async(dispatch_get_main_queue(), {
                        if url == self.imageURL {
                            if let imageData = contentsOfURL {
                                self.image = UIImage(data: imageData)
                            } else {
                                self.spinner?.stopAnimating()
                            }
                        } else {
                            print("Ignored data returned from url \(url)")
                    }
                })
            }
        }
    }
    
    // Zoom scroll
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
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
