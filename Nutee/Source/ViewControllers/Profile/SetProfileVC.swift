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
    var profileImgSrc : String?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        
        setIMGBtn.addTarget(self, action: #selector(showImagePickerController), for: .touchUpInside)
        closeBtn.addTarget(self, action: #selector(close), for: .touchUpInside)
        saveBtn.addTarget(self, action: #selector(saveChangedProfileInfo), for: .touchUpInside)
        
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
        profileIMG.imageFromUrl((APIConstants.BaseURL) + "/" + (profileImgSrc ?? ""), defaultImgPath: "http://15.164.50.161:9425/settings/nutee_profile.png")

        nameTextField.addBorder(.bottom, color: .nuteeGreen, thickness: 1)
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
    
    @objc func saveChangedProfileInfo() {
        // 닉네임 변경
        if nameTextField.text != "" {
            changeNicknameService(changedNickname: nameTextField.text!)
        } else {
            let emptyAlert = UIAlertController(title: nil, message: "닉네임을 입력하세요!", preferredStyle: UIAlertController.Style.alert)
            let okayAction = UIAlertAction(title: "확인", style: .default)
            emptyAlert.addAction(okayAction)
            self.present(emptyAlert, animated: true, completion: nil)
        }
        
        // 프로필 이미지 변경
        changeProfileImageService(image: [pickedIMG])
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

// MARK: - 프로필 이미지 혹은 닉네임 변경을 위한 서버 연결 코드
extension SetProfileVC {
    func changeNicknameService(changedNickname: String){
        UserService.shared.chageNickname(changedNickname) {
            [weak self]
            data in
            
            guard let `self` = self else { return }
            
            switch data {
            case .success(_ ):
                
                self.dismiss(animated: true, completion: nil)
            case .requestErr:
                print("requestErr")
            case .pathErr:
                print(".pathErr")
                
            case .serverErr:
                print(".serverErr")
                
            case .networkFail:
                print(".networkFail")
            }
        }
    }
    
    func changeProfileImageService(image: [UIImage]){
        UserService.shared.changeProfileImage(image) {
            [weak self]
            data in
            
            guard let `self` = self else { return }
            
            switch data {
            case .success(_ ):
                
                self.dismiss(animated: true, completion: nil)
            case .requestErr:
                print("requestErr")
            case .pathErr:
                print(".pathErr")
                
            case .serverErr:
                print(".serverErr")
                
            case .networkFail:
                print(".networkFail")
            }
        }
    }
}
