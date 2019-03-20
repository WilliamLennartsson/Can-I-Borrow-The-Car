//
//  CreateCarViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-03-20.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit
import ProgressHUD

class CreateCarPlaceholder: UITextField, Jiggerable {}

class CreateCarViewController: UIViewController {

    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carNameText: CreateCarPlaceholder!
    @IBOutlet weak var licencePlateText: CreateCarPlaceholder!
    @IBOutlet weak var modelText: CreateCarPlaceholder!
    
    var selectImageFromPicker: UIImage?
    var emptyField = true

    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeCarImageOnClick()
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func uploadCar_Button(_ sender: Any) {
        handleFields()
        if emptyField == false {
            createCar()
        }
    }
    
    func createCar() {
        let photo = selectImageFromPicker
        ProgressHUD.show("Processing...")
        if let carImage = photo {
            if let imageData = carImage.jpegData(compressionQuality: 0.1) {
                API.Car.uploadCar(carName: carNameText.text!, licencePlate: licencePlateText.text!, model: modelText.text!, imageData: imageData, completion: {
                    ProgressHUD.showSuccess("Car created")
                    self.resetCar()
                    self.navigationController?.popViewController(animated: true)
                }) { (error) in
                    ProgressHUD.showError(error)
                }
            }
        } else {
            ProgressHUD.showError("Image can't be empty")
        }
    }
    


    func resetCar() {
        self.carNameText.text = ""
        self.licencePlateText.text = ""
        self.modelText.text = ""
        self.selectImageFromPicker = nil
    }
    
    func handleFields() {
        if carNameText.text!.isEmpty {
            carNameText.jigger()
            emptyField = true
        }
        
        if licencePlateText.text!.isEmpty {
            licencePlateText.jigger()
            emptyField = true
        }
        
        if modelText.text!.isEmpty {
            modelText.jigger()
            emptyField = true
        }
        
        if carNameText.text!.isEmpty == false && licencePlateText.text!.isEmpty == false && modelText.text!.isEmpty == false {
            emptyField = false
        }
        
    }

}
