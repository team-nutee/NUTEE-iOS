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
        //        self.postingTextView.becomeFirstResponder()
        
        self.postingTextView.placeholder = "내용을 입력해주세요"
        postBtn.isEnabled = false
        
        self.tabBarController?.tabBar.isHidden = true
        
        textViewDidChange(postingTextView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        // 화면 나갈때 탭바 감추기 해제
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    // MARK: - Helper
    
    func initSetting() {
        self.postingTextView.tintColor = .nuteeGreen
        
        closeBtn.tintColor = .nuteeGreen
        postBtn.tintColor = .veryLightPink
        
        imagePickerBtn.tintColor = .nuteeGreen
        imagePickerView.layer.addBorder([.top, .bottom], color: .veryLightPink, width: 1)
        
    }
    
    @objc func closePosting() {
        
        tabBarController!.selectedIndex = 0
    }
    
    @objc func setPostBtn() {
        NotificationCenter.default.addObserver(forName: UITextView.textDidChangeNotification, object: postingTextView, queue: OperationQueue.main) { (notification) in
            if self.postingTextView.text != ""{
                self.postBtn.isEnabled = true
                self.postBtn.tintColor = .nuteeGreen
            } else {
                self.postBtn.isEnabled = false
                self.postBtn.tintColor = .veryLightPink
            }
        }
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
            
            pickerViewBottomConstraint.constant = keyboardHeight - tabbarHeight
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
    
    //    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
    //
    //    }
    
}

class TextView: UITextView {
    
    convenience init() {
        self.init(frame: CGRect.zero, textContainer: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChangeNotification), name: UITextView.textDidChangeNotification , object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func textDidChangeNotification(_ notif: Notification) {
        guard self == notif.object as? UITextView else {
            return
        }
        textDidChange()
    }
    
    func textDidChange() {
        // the text in the textview just changed, below goes the code for whatever you need to do given this event
        print("start")
        // or you can just set the textDidChangeHandler closure to execute every time the text changes, useful if you want to keep logic out of the class
        textDidChangeHandler?()
    }
    
    var textDidChangeHandler: (()->Void)?
    
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
        if textView.text != "" {
            postBtn.tintColor = .nuteeGreen
            postBtn.isEnabled = false
        }
        print(textView.text)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
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
