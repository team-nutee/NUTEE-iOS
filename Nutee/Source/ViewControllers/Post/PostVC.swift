//
//  PostVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/03.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit
import YPImagePicker
import AVFoundation
import AVKit
import Photos


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
    
    var pickedIMG : [UIImage] = []
    
    
    var selectedItems = [YPMediaItem]()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSetting()
        
        postingTextView.delegate = self
        imageCV.delegate = self
        imageCV.dataSource = self
        
        closeBtn.addTarget(self, action: #selector(closePosting), for: .touchUpInside)
        imagePickerBtn.addTarget(self, action: #selector(showPicker), for: .touchUpInside)
        postBtn.addTarget(self, action: #selector(posting), for: .touchUpInside)
        
        activePostBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        addKeyboardNotification()
        self.postingTextView.becomeFirstResponder()
        
        self.postingTextView.placeholder = "내용을 입력해주세요"
        postBtn.isEnabled = false
        textViewDidChange(postingTextView)

    }
        
    // MARK: - Helper
    
    func initSetting() {
        self.postingTextView.tintColor = .nuteeGreen
        
        closeBtn.tintColor = .nuteeGreen
        postBtn.tintColor = .nuteeGreen
        
        imagePickerBtn.tintColor = .nuteeGreen
        imagePickerView.addBorder(.top, color: .nuteeGreen, thickness: 1)
        imagePickerView.alpha = 0.6
    }
    
    func setDefault() {
        print(#function)
        self.postingTextView.text = ""
        self.pickedIMG = []
        self.imageCV.reloadData()
    }
    
    @objc func closePosting() {
        setDefault()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func posting(){
        
        LoadingHUD.show()
        
        // 사진이 있을때는 사진 올리고 게시물 업로드를 위한 분기처리
        if pickedIMG != [] {
            postImage(images: pickedIMG)
        } else {
            postContent(images: [], postContent: postingTextView.text)
        }
    }
    
    @objc func activePostBtn() {
        NotificationCenter.default.addObserver(forName: UITextView.textDidChangeNotification, object: postingTextView , queue: OperationQueue.main) { (notification) in
            if self.postingTextView.text != "" || self.pickedIMG != []{
                self.postBtn.isEnabled = true
            } else {
                self.postBtn.isEnabled = false
            }
        }
    }
    
}

// MARK: - YPImagePicker

extension PostVC {
    @objc func showPicker() {
        var config = YPImagePickerConfiguration()
        
        config.showsPhotoFilters = false
        config.shouldSaveNewPicturesToAlbum = true
        config.startOnScreen = .library
        config.wordings.libraryTitle = "Gallery"
        config.maxCameraZoomFactor = 2.0
        config.library.maxNumberOfItems = 10
        config.gallery.hidesRemoveButton = false
        config.hidesBottomBar = false
        config.hidesStatusBar = false
        config.library.preselectedItems = selectedItems
        
        
        config.colors.tintColor = .nuteeGreen

        let picker = YPImagePicker(configuration: config)
        
        picker.didFinishPicking { [unowned picker] items, cancelled in
            self.pickedIMG = []
            if cancelled {
                picker.dismiss(animated: true, completion: nil)
                return
            }
            
            for item in items {
                
                switch item {
                    
                case .photo(let p):
                    self.pickedIMG.append(p.image)
                    
                default:
                    print("")
                    
                }
                
            }
            picker.dismiss(animated: true) {
                self.imageCV.reloadData()
            }
        }
        
        present(picker, animated: true, completion: nil)
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
            let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            let bottomPadding = keyWindow?.safeAreaInsets.bottom ?? 0
            
            pickerViewBottomConstraint.constant = -( keyboardHeight - (bottomPadding))
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight - bottomPadding, right: 0)
            
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
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if self.postingTextView.text != ""{
            self.postBtn.isEnabled = true
        } else {
            self.postBtn.isEnabled = false
        }
        return true
    }
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostIMGCVC", for: indexPath) as! PostIMGCVC
        
        cell.postIMG.image = nil
        pickedIMG.remove(at: indexPath.row)
        
        self.imageCV.reloadData()
    }
    
}

extension PostVC {
    func postContent(images: [NSString], postContent: String){
        ContentService.shared.uploadPost(pictures: images, postContent: postContent){
            [weak self]
            data in
            
            guard let `self` = self else { return }
            
            switch data {
            case .success(_ ):
                
                LoadingHUD.hide()
                self.dismiss(animated: true, completion: nil)
            case .requestErr:
                LoadingHUD.hide()
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
    
    func postImage(images: [UIImage]){
        ContentService.shared.uploadImage(pictures: images){
            [weak self]
            data in
            
            guard let `self` = self else { return }
            
            switch data {
            case .success(let res):
                // 데이터 타입 변경
                debugPrint("234 :",res)
                // 포스팅 서버 연결
                self.postContent(images: res as! [NSString], postContent: self.postingTextView.text)
                
            case .requestErr:
                self.simpleAlert(title: "실패", message: "")
                
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
