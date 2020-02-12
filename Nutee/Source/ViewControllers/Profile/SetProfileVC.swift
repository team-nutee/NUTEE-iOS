//
//  SetProfileVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/06.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class SetProfileVC: UIViewController {
    
    // MARK: - UI components
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var profileIMG: UIImageView!
    @IBOutlet weak var setIMGBtn: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    // MARK: - Variables and Properties
    let picker = UIImagePickerController()
    var pickedIMG = UIImage()
    var name : String = ""
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        
        setIMGBtn.addTarget(self, action: #selector(showImagePickerController), for: .touchUpInside)
        closeBtn.addTarget(self, action: #selector(close), for: .touchUpInside)
        setInit()
    }
    
    // MARK: -Helpers
    
    // 초기 설정
    func setInit() {
        closeBtn.tintColor = .nuteeGreen
        closeBtn.titleLabel?.font = .boldSystemFont(ofSize: 15)
        saveBtn.tintColor = .nuteeGreen
        saveBtn.titleLabel?.font = .boldSystemFont(ofSize: 15)
        setIMGBtn.tintColor = .white
        setIMGBtn.backgroundColor = .nuteeGreen
        profileIMG.backgroundColor = .lightGray
        
        nameTextField.layer.addBorder([.bottom], color: .nuteeGreen, width: 1)
        nameTextField.tintColor = .nuteeGreen
        nameTextField.text = name
        
        setIMGBtn.setRounded(radius: nil)
        profileIMG.setRounded(radius: nil)
    }
    
    func setDefault() {
        
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SetProfileVC : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @objc func showImagePickerController() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage  {
            self.profileIMG.image = image
            self.pickedIMG = image
        }
        
        dismiss(animated: true, completion:  nil)
    }
}
