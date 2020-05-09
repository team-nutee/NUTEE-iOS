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
    
    @IBOutlet weak var checkLabel: UILabel!
    // MARK: - Variables and Properties
    
    let picker = UIImagePickerController()
    var pickedIMG = UIImage()
    var name : String = ""
    var profileImgSrc : String?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        nameTextField.delegate = self
        setIMGBtn.addTarget(self, action: #selector(tapImageSettingBtn), for: .touchUpInside)
        closeBtn.addTarget(self, action: #selector(close), for: .touchUpInside)
        saveBtn.addTarget(self, action: #selector(saveChangedProfileInfo), for: .touchUpInside)
        nameTextField.addTarget(self, action: #selector(checkName), for: .editingDidEnd)
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
        
        profileIMG.setImageNutee(profileImgSrc)
        
        nameTextField.addBorder(.bottom, color: .nuteeGreen, thickness: 1)
        nameTextField.tintColor = .nuteeGreen
        nameTextField.text = name
        
        setIMGBtn.setRounded(radius: nil)
        profileIMG.setRounded(radius: nil)
        setClickProfileImageActions()
        
        checkLabel.alpha = 0
    }
    
    func setDefault() {
        
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    // 프로필 이미지에 탭 인식하게 만들기
    func setClickProfileImageActions() {
        profileIMG.tag = 1
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped(tapGestureRecognizer:)))
        tapGestureRecognizer1.numberOfTapsRequired = 1
        profileIMG.isUserInteractionEnabled = true
        profileIMG.addGestureRecognizer(tapGestureRecognizer1)
    }
    
    // 프로필 이미지 클릭시 실행 함수
    @objc func profileImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let imgView = tapGestureRecognizer.view as! UIImageView
        print("your taped image view tag is : \(imgView.tag)")
        
        //Give your image View tag
        if (imgView.tag == 1) {
            tapImageSettingBtn()
        }
    }
    
    @objc func tapImageSettingBtn(){
        let actionAlert = UIAlertController(title: nil,
                                            message: nil,
                                            preferredStyle: UIAlertController.Style.actionSheet)
        let defaultAction = UIAlertAction(title:"기본 누티 이미지로 설정", style: .default){ action in
            self.profileIMG.setImageNutee("")
            self.profileIMG.setImageContentMode("", imgvw: self.profileIMG)
        }
        let imagePickerAction = UIAlertAction(title: "앨범에서 이미지 선택", style: .default) { (action) in
            self.showImagePickerController()
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        actionAlert.addAction(defaultAction)
        actionAlert.addAction(imagePickerAction)
        actionAlert.addAction(cancelAction)
        self.present(actionAlert, animated: true)
    }
    
    @objc func saveChangedProfileInfo() {
        // 닉네임 변경
        if nameTextField.text != "" {
            checkName()
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
            self.profileIMG.setImageContentMode("ThisIsStringForSetContentMode", imgvw: self.profileIMG)
            self.pickedIMG = image
        }
        
        dismiss(animated: true, completion:  nil)
    }
}

extension SetProfileVC: UITextFieldDelegate { }

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
    
    @objc func checkName(){
        print(#function)
        UserService.shared.checkNick(nameTextField.text!) { (responsedata) in
            print(#function)
            switch responsedata {
                
            case .success(let res):
                print(res)
                self.changeNicknameService(changedNickname: self.nameTextField.text!)
                
            case .requestErr(let res):
                print(res)
                self.checkLabel.shake(duration: 0.3)
                self.nameTextField.addBorder(.bottom, color: .red, thickness: 1)
                self.checkLabel.textColor = .red
                self.checkLabel.text = "이미 사용중인 닉네임입니다."
                self.checkLabel.sizeToFit()
                self.checkLabel.alpha = 1
                
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
