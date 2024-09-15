//
//  TaskComposeViewController.swift
//  lab-task-squirrel
//
//  Created by Charlie Hieger on 11/15/22.
//

import UIKit

class ScavengeComposeViewController: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!

    // When a new task is created, this closure is called, passing in the newly created task.
    var onComposeScavenge: ((Scavenge) -> Void)? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func didTapDoneButton(_ sender: Any) {

        guard let title = titleField.text,
              let description = descriptionField.text,
              !title.isEmpty,
              !description.isEmpty else {
            presentEmptyFieldsAlert()
            return
        }

        let scavenge = Scavenge(title: title, description: description)
        onComposeScavenge?(scavenge)
        dismiss(animated: true)
    }

    
    @IBAction func didTapCancelButton(_ sender: Any) {
        dismiss(animated: true)
    }

    private func presentEmptyFieldsAlert() {
        let alertController = UIAlertController(
            title: "Oops...",
            message: "Both title and description fields must be filled out",
            preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)

        present(alertController, animated: true)
    }
}
