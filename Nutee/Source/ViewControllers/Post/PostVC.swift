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
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var postingTextView: UITextView!
    @IBOutlet weak var imageCV: UICollectionView!
    @IBOutlet weak var imagePickerBtn: UIButton!
    
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

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.postingTextView.placeholder = "내용을 입력해주세요"
        self.postingTextView.becomeFirstResponder()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 화면 나갈때 탭바 감추기 해제
        self.tabBarController?.tabBar.isHidden = false
    }


    // MARK: - Helper
    
    func initSetting() {
        self.postingTextView.tintColor = .nuteeGreen
        closeBtn.tintColor = .nuteeGreen
        postBtn.tintColor = .veryLightPink

    }
    
    @objc func closePosting() {
//        tabBarController?.tabBar.isHidden = false
        tabBarController!.selectedIndex = 0
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
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        postBtn.tintColor = .nuteeGreen
    }
    
    
}


extension PostVC: UICollectionViewDelegate { }

extension PostVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pickedIMG.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostIMGCVC", for: indexPath) as! PostIMGCVC
        
        cell.postIMG.image = pickedIMG[indexPath.row]
        cell.postIMG.cornerRadius = 10

    
        cell.backgroundColor = .nuteeGreen2
        
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
