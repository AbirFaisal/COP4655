//
//  PhotoViewController.swift
//  lab-task-squirrel
//
//

import UIKit


class PhotoViewController: UIViewController {
    
    @IBOutlet weak var selectedImageView: UIImageView!
    
    var task: Task!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedImageView.image = task.image
    }
}
