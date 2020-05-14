//
//  AddItemViewController.swift
//  FrontYardMarket
//
//  Created by Dustin yang on 5/13/20.
//  Copyright © 2020 Dustin yang. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var cameraButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func doneBarButtonItemPressed(_ sender: Any) {
        dismissKeayboard()
        
        if fieldsAreCompleted() {
            print("we have values")
        } else {
            print("Error all fields are required")
            //TODO: SHow error to the user
            
        }
        
    }
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
    }
    
    //MARK: Helper functions
    
    private func fieldsAreCompleted() -> Bool {
        
        return (titleTextField.text != "" && priceTextField.text != "" && descriptionTextView.text != "")
    }
    
    private func dismissKeayboard() {
        self.view.endEditing(false)
    }
    
}
