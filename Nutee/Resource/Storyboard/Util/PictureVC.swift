//
//  PictureVC.swift
//  Nutee
//
//  Created by Junhyeon on 2020/03/25.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class PictureVC: UIViewController {

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var beforeBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    var imageArr: [Image]?
    var imageNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        view.backgroundColor = nil
        imageView.contentMode = .scaleAspectFit
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundView?.backgroundColor = nil
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 2.4
        imageView.setImageNutee(imageArr?[imageNumber].src)
        
        
        backBtn.tintColor = .white
        backBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        setBtn()
    }
    
    @objc func back(){
        dismiss(animated: false, completion: nil)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        dismiss(animated: false)
    }
    

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }

    func setBtn(){
        beforeBtn.tintColor = .nuteeGreen
        nextBtn.tintColor = .nuteeGreen
        beforeBtn.backgroundColor = .veryLightPink
        nextBtn.backgroundColor = .veryLightPink
        beforeBtn.alpha = 0.65
        nextBtn.alpha = 0.65
        
        beforeBtn.setRounded(radius: nil)
        nextBtn.setRounded(radius: nil)
        
        beforeBtn.addTarget(self, action: #selector(before), for: .touchUpInside)
        nextBtn.addTarget(self, action: #selector(tapNext), for: .touchUpInside)
    }
    
    @objc func before(){
        if imageNumber == 0 {
            imageNumber = imageArr!.count - 1
            imageView.setImageNutee(imageArr![imageNumber].src)
        } else {
            imageNumber = imageNumber - 1
            imageView.setImageNutee(imageArr![imageNumber].src)
        }
    }
    
    @objc func tapNext(){
        if imageNumber == (imageArr!.count - 1) {
            imageNumber = 0
            imageView.setImageNutee(imageArr![imageNumber].src)
        } else {
            imageNumber = imageNumber + 1
            imageView.setImageNutee(imageArr![imageNumber].src)
        }

    }
}

extension PictureVC: UIScrollViewDelegate{ }

extension PictureVC: UICollectionViewDelegate { }

extension PictureVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCVC",
                                                      for: indexPath) as! PictureCVC
        
        cell.collectionImageView.setImageNutee(imageArr![indexPath.row].src)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imageView.setImageNutee(imageArr![indexPath.row].src)
        imageNumber = indexPath.row
    }
}
