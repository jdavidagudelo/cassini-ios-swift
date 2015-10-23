//
//  ImageViewController.swift
//  Cassini
//
//  Created by Ingenieria y Software on 22/10/15.
//  Copyright © 2015 Ingenieria y Software. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var scrollView: UIScrollView!{
        didSet{
            scrollView.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0
        }
    }
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    var imageURL: NSURL?
        {
        didSet{
            image = nil
            if view.window != nil
            {
                fetchImage()
            }
        }
    }
    
    private func fetchImage(){
        if let url = imageURL
        {
            activityIndicator?.startAnimating()
            let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)
            dispatch_async(dispatch_get_global_queue(qos, 0)){ () -> Void  in
                let imageData = NSData(contentsOfURL: url)
                dispatch_async(dispatch_get_main_queue()){
                    () -> Void in
                    if url == self.imageURL
                    {
                        if imageData != nil{
                            self.image = UIImage(data: imageData!)
                        }
                        else
                        {
                            self.image = nil
                        }
                    }
                }
                
            }
           
        }
    }
    private var imageView = UIImageView()
    private var image: UIImage?{
        get{
            return imageView.image
        }
        set{
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            activityIndicator?.stopAnimating()
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            fetchImage()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
    }
    
}
