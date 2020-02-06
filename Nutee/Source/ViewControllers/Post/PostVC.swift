//
//  PostVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/03.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class PostVC: UIViewController {
    
    // MARK: - UI components
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var postingTextView: UITextView!
    @IBOutlet weak var imageCV: UICollectionView!
    @IBOutlet weak var imagePickerBtn: UIButton!
    @IBOutlet weak var imagePickerView: UIView!
    
    @IBOutlet weak var pickerViewBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Variables and Properties
    
    let picker = UIImagePickerController()
    var pickedIMG : [UIImage] = []
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSetting()
        
        picker.delegate = self
        postingTextView.delegate = self
        imageCV.delegate = self
        imageCV.dataSource = self
        
        closeBtn.addTarget(self, action: #selector(closePosting), for: .touchUpInside)
        imagePickerBtn.addTarget(self, action: #selector(showImagePickerController), for: .touchUpInside)
        
        setPostBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        addKeyboardNotification()
        self.postingTextView.becomeFirstResponder()
        
        self.postingTextView.placeholder = "내용을 입력해주세요"
        postBtn.isEnabled = false
        
//        hideTabbar()
        
        textViewDidChange(postingTextView)
        setDefault()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        // 화면 나갈때 탭바 감추기 해제
//        showTabbar()
    }
    
    
    // MARK: - Helper
    
    func initSetting() {
        self.postingTextView.tintColor = .nuteeGreen
        
        closeBtn.tintColor = .nuteeGreen
        postBtn.tintColor = .veryLightPink
        
        imagePickerBtn.tintColor = .nuteeGreen
        imagePickerView.layer.addBorder([.top], color: .nuteeGreen, width: 1)
        imagePickerView.alpha = 0.6
    }
    
    func setDefault() {
        self.postingTextView.text = ""
        self.pickedIMG = []
        self.imageCV.reloadData()
    }

    @objc func closePosting() {
        tabBarController!.selectedIndex = 0
    }
    
    @objc func setPostBtn() {
        NotificationCenter.default.addObserver(forName: UITextView.textDidChangeNotification, object: postingTextView, queue: OperationQueue.main) { (notification) in
            if self.postingTextView.text != "" || self.pickedIMG != []{
                self.postBtn.isEnabled = true
                self.postBtn.tintColor = .nuteeGreen
            } else {
                self.postBtn.isEnabled = false
                self.postBtn.tintColor = .veryLightPink
            }
        }
    }
    
    func hideTabbar() {
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
    }
    
    func showTabbar() {
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.isTranslucent = false
    }
    
}


// MARK: - KeyBoard

extension PostVC {
    func addKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification)  {
        if let info = notification.userInfo {
            let duration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
            let curve = info[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
            let keyboardFrame = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let keyboardHeight = keyboardFrame.height
            let tabbarHeight = self.tabBarController?.tabBar.frame.size.height ?? 0
            
            pickerViewBottomConstraint.constant = -(keyboardHeight - tabbarHeight)
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight - tabbarHeight, right: 0)
            
            self.view.setNeedsLayout()
            UIView.animate(withDuration: duration, delay: 0, options: .init(rawValue: curve), animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        if let info = notification.userInfo {
            let duration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
            let curve = info[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
            
            pickerViewBottomConstraint.constant = 0
            scrollView.contentInset = .zero
            self.view.setNeedsLayout()
            UIView.animate(withDuration: duration, delay: 0, options: .init(rawValue: curve), animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }

}

// MARK: - UITextViewDelegate

extension PostVC: UITextViewDelegate {
    
    // TextView의 동적인 크기 변화를 위한 function
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
    
}

// MARK: -UICollectionView

extension PostVC: UICollectionViewDelegate { }

extension PostVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pickedIMG.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostIMGCVC", for: indexPath) as! PostIMGCVC
        
        cell.postIMG.image = pickedIMG[indexPath.row]
        cell.postIMG.cornerRadius = 10
        
        return cell
    }
    
}

// MARK: - ImagePickerDelegate

extension PostVC : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @objc func showImagePickerController() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.pickedIMG.append(selectImage)
            self.imageCV.reloadData()
            
        }
        
        dismiss(animated: true, completion:  nil)
    }
}
