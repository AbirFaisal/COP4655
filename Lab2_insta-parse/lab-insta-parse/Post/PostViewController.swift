//
//  PostViewController.swift
//  lab-insta-parse
//
//  Created by Charlie Hieger on 11/1/22.
//

import UIKit

// TODO: Import Photos UI
import PhotosUI
// TODO: Import Parse Swift
import ParseSwift

class PostViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var captionTextField: UITextField!
    @IBOutlet weak var previewImageView: UIImageView!

    private var pickedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onPickedImageTapped(_ sender: UIBarButtonItem) {
        // TODO: Pt 1 - Present Image picker
        var config = PHPickerConfiguration()
        config.filter = .images
        config.preferredAssetRepresentationMode = .current
        config.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: config)
        
        picker.delegate = self
        
        present(picker, animated: true)
    }

    @IBAction func onShareTapped(_ sender: Any) {

        // Dismiss Keyboard
        view.endEditing(true)

        // TODO: Pt 1 - Create and save Post


    }

    @IBAction func onViewTapped(_ sender: Any) {
        // Dismiss keyboard
        view.endEditing(true)
    }

    private func showAlert(description: String? = nil) {
        let alertController = UIAlertController(title: "Oops...", message: "\(description ?? "Please try again...")", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}

// TODO: Pt 1 - Add PHPickerViewController delegate and handle picked image.
extension PostViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard
            let provider = results.first?.itemProvider,
            provider.canLoadObject(ofClass: UIImage.self)
        else {
            return
        }
        
        provider.loadObject(ofClass: UIImage.self) {
            [weak self] object, error in
            
            
            guard
                let image = object as? UIImage
            else{
                self?.showAlert()
                return
            }
            
            
            if let error = error {
                self?.showAlert(description: error.localizedDescription)
            }
            else {

                  DispatchQueue.main.async {

                     self?.previewImageView.image = image

                     self?.pickedImage = image
                  }
               }

        }
    }
}

