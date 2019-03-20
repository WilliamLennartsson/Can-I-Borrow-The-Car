//
//  CameraPicker.swift
//  Instagram-FIR
//
//  Created by Kristoffer Knape on 2018-10-16.
//  Copyright © 2018 Kristoffer Knape. All rights reserved.
//

import Foundation
import UIKit

extension RegisterUserViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func changeProfileImageOnClick() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(RegisterUserViewController.handleProfileView))
        profileImageView.addGestureRecognizer(tapGesture)
        profileImageView.isUserInteractionEnabled = true
        AppStyle.cirlceUIImageView(image: profileImageView)
        self.hideKeyboardWhenTappedAround()
    }

    @objc func handleProfileView() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        print(info)

        if let editedImage = info[.editedImage] as? UIImage {
            selectImageFromPicker = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectImageFromPicker = originalImage
        }

        if let selectedImage = selectImageFromPicker {
            self.isPicturePicked = true
            profileImageView.image = selectedImage
        }

        dismiss(animated: true, completion: nil)
    }

}
