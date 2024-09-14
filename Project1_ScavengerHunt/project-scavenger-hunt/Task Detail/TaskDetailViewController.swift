//
//  TaskDetailViewController.swift
//  lab-task-squirrel
//
//  Created by Charlie Hieger on 11/15/22.
//

import UIKit
import MapKit

// TODO: Import PhotosUI
import PhotosUI

class TaskDetailViewController: UIViewController {

    @IBOutlet private weak var completedImageView: UIImageView!
    @IBOutlet private weak var completedLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var attachPhotoButton: UIButton!
    
    // Step 8
    @IBOutlet weak var viewSelectedImageButton: UIButton!
    

    // MapView outlet
    @IBOutlet private weak var mapView: MKMapView!

    var task: Scavenge!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Step 7
        // TODO: Register custom annotation view
        let tavID = TaskAnnotationView.identifier
        mapView.register(TaskAnnotationView.self, forAnnotationViewWithReuseIdentifier: tavID)

        // TODO: Set mapView delegate
        mapView.delegate = self

        // UI Candy
        mapView.layer.cornerRadius = 12


        updateUI()
        updateMapView()
    }

    /// Configure UI for the given task
    private func updateUI() {
        titleLabel.text = task.title
        descriptionLabel.text = task.description

        let completedImage = UIImage(systemName: task.isComplete ? "circle.inset.filled" : "circle")

        // calling `withRenderingMode(.alwaysTemplate)` on an image allows for coloring the image via it's `tintColor` property.
        completedImageView.image = completedImage?.withRenderingMode(.alwaysTemplate)
        completedLabel.text = task.isComplete ? "Complete" : "Incomplete"

        let color: UIColor = task.isComplete ? .systemBlue : .tertiaryLabel
        completedImageView.tintColor = color
        completedLabel.textColor = color

        mapView.isHidden = !task.isComplete
        attachPhotoButton.isHidden = task.isComplete
        
        // Step 8
        viewSelectedImageButton.isHidden = !task.isComplete
    }

    @IBAction func didTapAttachPhotoButton(_ sender: Any) {
        // TODO: Check and/or request photo library access authorization.
        if PHPhotoLibrary.authorizationStatus(for: .readWrite) != .authorized {
            print("Requesting Photo Library Permissions")
            PHPhotoLibrary.requestAuthorization(for: .readWrite) {
                [weak self] status in
                    switch status {
                    case .authorized:
                        DispatchQueue.main.async {
                            self?.presentImagePicker()
                        }
                    default:
                        DispatchQueue.main.async {
                            self?.presentGoToSettingsAlert()
                        }
                    }
            }
            
        } else {
            self.presentImagePicker()
        }
    }

    private func presentImagePicker() {
        // TODO: Create, configure and present image picker.
        var conf = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        
        conf.filter = .images
        
        conf.preferredAssetRepresentationMode = .current
        
        conf.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: conf)
        
        picker.delegate = self
        
        present(picker, animated: true)

    }

    func updateMapView() {
        // TODO: Set map viewing region and scale
        // Step 5: Setup the map view

        guard
            let imageLocation = task.imageLocation
        else {
            return
        }
        
        let coordinate = imageLocation.coordinate
        let cordSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        let region = MKCoordinateRegion(center: coordinate, span: cordSpan)
        
        mapView.setRegion(region, animated: true)
        
        
        // TODO: Add annotation to map view
        // Step 6: Add an annotation
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    
    
    // Step 8 - pass information into the next view.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

            // Segue to Detail View Controller
         if segue.identifier == "PhotoSegue" {
             if let photoViewController = segue.destination as? PhotoViewController {
                 photoViewController.task = task
              }
          }
      }
    
    
}

// TODO: Conform to PHPickerViewControllerDelegate + implement required method(s)

// TODO: Conform to MKMapKitDelegate + implement mapView(_:viewFor:) delegate method.

// Helper methods to present various alerts
extension TaskDetailViewController {

    /// Presents an alert notifying user of photo library access requirement with an option to go to Settings in order to update status.
    func presentGoToSettingsAlert() {
        let alertController = UIAlertController (
            title: "Photo Access Required",
            message: "In order to post a photo to complete a task, we need access to your photo library. You can allow access in Settings",
            preferredStyle: .alert)

        let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl)
            }
        }

        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    /// Show an alert for the given error
    private func showAlert(for error: Error? = nil) {
        let alertController = UIAlertController(
            title: "Oops...",
            message: "\(error?.localizedDescription ?? "Please try again...")",
            preferredStyle: .alert)

        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)

        present(alertController, animated: true)
    }
}


extension TaskDetailViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        // Step 3: Get the location metadata from the chosen photo
        picker.dismiss(animated: true)
        
        let result = results.first
        
        guard 
            let assetId = result?.assetIdentifier,
            let location = PHAsset.fetchAssets(withLocalIdentifiers: [assetId], options: nil).firstObject?.location
        else {
            return
        }
        
        print("\(location.coordinate)")
        
        
        // Step 4: Get the image from the chosen photo
        guard
            let provider = result?.itemProvider, provider.canLoadObject(ofClass: UIImage.self)
        else{
            return
        }
        
        provider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    [weak self] in self?.showAlert(for:error)
                }
            }
            
            guard
                let image = object as? UIImage
            else {
                return
            }
            
            print("We have an image")
            
            DispatchQueue.main.async { [weak self] in
                
                self?.task.set(image, with:location)
                
                self?.updateUI()
                
                self?.updateMapView()
                
            }
        }
    }
}


extension TaskDetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = TaskAnnotationView.identifier
        
        guard 
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier, for: annotation)
                as? TaskAnnotationView
        else {
            fatalError("Unable to dequeue TaskAnnotationView")
        }
        
        annotationView.configure(with: task.image)
        
        return annotationView
    }
}
