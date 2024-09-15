//
//  PhotoViewController.swift
//  lab-task-squirrel
//
//

import UIKit


class PhotoViewController: UIViewController {
    
    @IBOutlet weak var selectedImageView: UIImageView!
    
    var scavenge: Scavenge!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedImageView.image = scavenge.image
    }
}
