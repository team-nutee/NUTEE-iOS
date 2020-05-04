//
//  PostVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/02/03.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import AVFoundation
import AVKit
import UIKit
import Photos

import YPImagePicker


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
    
    var uploadedImages: [NSString] = []
    
    var editNewsPost: NewsPostsContentElement?
    var isEditMode = false
    var editPostImg: [Image] = []
    
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
        postBtn.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        addKeyboardNotification()
        
        self.postingTextView.becomeFirstResponder()
        
        self.postingTextView.placeholder = "내용을 입력해주세요"
        
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
        self.postingTextView.text = ""
        self.pickedIMG = []
        self.imageCV.reloadData()
    }
    
    func setEditMode() {
        isEditMode = true
        postingTextView.text = editNewsPost?.content
        editPostImg = editNewsPost?.images ?? []
        closeBtn.setTitle("취소", for: .normal)
        postBtn.setTitle("수정", for: .normal)
    }
    
    @objc func closePosting() {
        simpleAlertWithHandler(title: "작성을 취소하시겠습니까??", msg: "") { (action) in
            self.setDefault()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func posting(){
        
        LoadingHUD.show()
        
        if isEditMode == false {
            // 사진이 있을때는 사진 올리고 게시물 업로드를 위한 분기처리
            if pickedIMG != [] {
                postImage(images: pickedIMG, completionHandler: {(returnedData)-> Void in
                    self.postContent(images: self.uploadedImages,
                                     postContent: self.postingTextView.text)
                })
            } else {
                postContent(images: [], postContent: postingTextView.text)
            }
        } else {
            // 사진이 있을때는 사진 올리고 게시물 업로드를 위한 분기처리
            var images: [String] = []
            for img in self.editPostImg {
                images.append(img.src ?? "")
            }
            if pickedIMG != [] {
                postImage(images: pickedIMG, completionHandler: {(returnedData)-> Void in
                    for uploadimg in self.uploadedImages {
                        images.append(uploadimg as String)
                    }
                    self.editPostContent(postId: self.editNewsPost?.id ?? 0,
                                         postContent: self.postingTextView.text, postImages: images)
                })
            } else {
                editPostContent(postId: editNewsPost?.id ?? 0,
                                postContent: postingTextView.text,
                                postImages: images)
            }
        }
        
        
    }
    
    @objc func activePostBtn() {
        NotificationCenter.default.addObserver(forName: UITextView.textDidChangeNotification,
                                               object: postingTextView ,
                                               queue: OperationQueue.main) { (notification) in
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
        config.wordings.libraryTitle = "갤러리"
        config.maxCameraZoomFactor = 2.0
        config.library.maxNumberOfItems = 10
        config.gallery.hidesRemoveButton = false
        config.hidesBottomBar = false
        config.hidesStatusBar = false
        config.library.preselectedItems = selectedItems
        config.colors.tintColor = .nuteeGreen
        config.overlayView = UIView()
        
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
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
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
            scrollView.contentInset = UIEdgeInsets(top: 0,
                                                   left: 0,
                                                   bottom: keyboardHeight - bottomPadding,
                                                   right: 0)
            
            self.view.setNeedsLayout()
            UIView.animate(withDuration: duration,
                           delay: 0,
                           options: .init(rawValue: curve),
                           animations: {
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
            UIView.animate(withDuration: duration,
                           delay: 0,
                           options: .init(rawValue: curve),
                           animations: {
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
    
    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        if self.postingTextView.text != "" {
            if pickedIMG.count != 0 || editPostImg.count != 0 {
                self.postBtn.isEnabled = true
            } else {
                self.postBtn.isEnabled = true
            }
        } else {
            if pickedIMG.count != 0 || editPostImg.count != 0 {
                self.postBtn.isEnabled = true
            } else {
                self.postBtn.isEnabled = false
            }
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
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if isEditMode == false {
            return pickedIMG.count
        } else {
            return (editPostImg.count ) + pickedIMG.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostIMGCVC",
                                                      for: indexPath) as! PostIMGCVC
        
        cell.postIMG.cornerRadius = 10
        if isEditMode == false {
            cell.postIMG.image = pickedIMG[indexPath.row]
            if ( pickedIMG.count != 0 || editPostImg.count != 0) {
                postBtn.isEnabled = true
            } else {
                postBtn.isEnabled = false
            }
        } else {
            if editPostImg.count >= 1 && indexPath.row < editPostImg.count {
                cell.postIMG.setImageNutee(editNewsPost?.images[indexPath.row].src ?? "")
                postBtn.isEnabled = true
            } else {
                let fixIndex = Int(indexPath.row) - (editPostImg.count)
                cell.postIMG.image = pickedIMG[fixIndex]
                postBtn.isEnabled = true
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if isEditMode == false {
            pickedIMG.remove(at: indexPath.row)
            if (pickedIMG.count != 0 || editPostImg.count > 1 || postingTextView.text != ""){
                postBtn.isEnabled = true
            } else {
                postBtn.isEnabled = false
            }
        } else {
            print(false)
            if editPostImg.count > 0 && indexPath.row < editPostImg.count {
                editPostImg.remove(at: indexPath.row)
                postBtn.isEnabled = true
            } else {
                let fixIndex = Int(indexPath.row) - (editPostImg.count)
                pickedIMG.remove(at: fixIndex)
                postBtn.isEnabled = true
            }
            
            if (pickedIMG.count != 0 || editPostImg.count != 0 || postingTextView.text != "" ){
                postBtn.isEnabled = true
            } else {
                postBtn.isEnabled = false
            }
            
        }
        
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
    
    func postImage(images: [UIImage],
                   completionHandler: @escaping (_ returnedData: [NSString]) -> Void ) {
        dump(images[0])

        ContentService.shared.uploadImage(pictures: images){
            [weak self]
            data in
            
            guard let `self` = self else { return }
            
            switch data {
            case .success(let res):
                self.uploadedImages = res as! [NSString]
                print(".successful uploadImage")
                completionHandler(self.uploadedImages)
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
    
    func editPostContent(postId: Int, postContent: String, postImages: [String]){
        ContentService.shared.editPost(postId, postContent, postImages){
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
    
}
