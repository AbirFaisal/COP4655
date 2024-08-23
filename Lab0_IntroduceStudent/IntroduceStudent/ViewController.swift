//
//  ViewController.swift
//  IntroduceStudent
//
//  Created by Abir Faisal on 8/18/24.
//

import UIKit

class ViewController: UIViewController {
    
    // UI elements
    @IBOutlet weak var fnTextField: UITextField!
    @IBOutlet weak var lnTextField: UITextField!
    @IBOutlet weak var schoolTextField: UITextField!
    @IBOutlet weak var yearSelectControl: UISegmentedControl!
    @IBOutlet weak var nPetsValueLabel: UILabel!
    @IBOutlet weak var nPetsStepper: UIStepper!
    @IBOutlet weak var morePetsSwitch: UISwitch!
    @IBOutlet weak var introduceSelfButton: UIButton!
    

    // Action Handlers
    @IBAction func nPetsActionHandler(_ sender: Any) {
        self.nPetsValueLabel.text = "\(Int(self.nPetsStepper.value))"
        print("nPets stepper pressed")
    }
    
    @IBAction func introduceButtonHandler(_ sender: UIButton) {
        let firstName = self.fnTextField.text!
        let lastName = self.lnTextField.text!
        let schoolName = self.schoolTextField.text!
        let classYear = self.yearSelectControl.titleForSegment(at: self.yearSelectControl.selectedSegmentIndex)
        let nPets = "\(Int(self.nPetsStepper.value))"
        let morePets = self.morePetsSwitch.isOn
        
        let introduction = "My name is \(firstName) \(lastName), I attend \(schoolName) and I am in my \(classYear!) year I own \(nPets) pets and it is \(morePets) that I want more."
        
        self.presentIntroDialog(dialogString: introduction)
    }
    
    func presentIntroDialog(dialogString: String) {
        
        let alertController = UIAlertController(title: "My Introduction", message: dialogString, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Nice to meet you!", style: .default, handler: nil)
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

