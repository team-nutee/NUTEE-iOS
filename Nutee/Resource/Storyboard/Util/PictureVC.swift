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
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var backBtn: UIButton!
    
    
    var imageArr : [Image]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        view.backgroundColor = nil
        
        pageControl.numberOfPages = imageArr?.count ?? 0
        pageControl.currentPage = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.view.bringSubviewToFront(pageControl)
        
        setScrollView()
        
        backBtn.tintColor = .nuteeGreen
        backBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
    }
    
    @objc func back(){
        dismiss(animated: false, completion: nil)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        dismiss(animated: false)
    }
    
    func setScrollView(){
        for i in 0 ..< (imageArr?.count ?? 0) {
            let imageView = UIImageView()
            imageView.imageFromUrl((APIConstants.BaseURL) + "/" + (imageArr?[i].src ?? ""), defaultImgPath: (APIConstants.BaseURL) + "/settings/nutee_profile.png")
            
            imageView.contentMode = .scaleAspectFill //  사진의 비율을 맞춤.
            let xPosition = self.view.frame.width * CGFloat(i) // 현재 보이는 스크린에서 하나의 이미지만 보이게 하기 위해
                    
            imageView.frame = CGRect(x: xPosition, y: (scrollView.frame.height-self.view.frame.width)/2, width: self.view.frame.width, height: self.view.frame.width)            
            
            scrollView.contentSize.width = self.view.frame.width * CGFloat(1+i)

            scrollView.addSubview(imageView)
        }

    }

}

extension PictureVC : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = round(scrollView.contentOffset.x / self.view.frame.width)
        pageControl.currentPage = Int(CGFloat(currentPage))
    }

}
