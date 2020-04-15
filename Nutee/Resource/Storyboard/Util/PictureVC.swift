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
    var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        view.backgroundColor = nil
        
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 1.5
        
        
        pageControl.numberOfPages = imageArr?.count ?? 0
        pageControl.currentPage = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.view.bringSubviewToFront(pageControl)
        
        setScrollView()
        
        backBtn.tintColor = .white
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
            imageView = UIImageView()
            scrollView.contentSize = imageView.frame.size
            imageView.imageFromUrl((APIConstants.BaseURL) + "/" + (imageArr?[i].src ?? ""), defaultImgPath: (APIConstants.BaseURL) + "/settings/nutee_profile.png")
            
            imageView.contentMode = .scaleAspectFit
            let xPosition = self.view.frame.width * CGFloat(i) // 현재 보이는 스크린에서 하나의 이미지만 보이게 하기 위해
                    
            imageView.frame = CGRect(x: xPosition, y: (scrollView.frame.height-self.view.frame.width)/2, width: self.view.frame.width, height: self.view.frame.width)
            
            scrollView.contentSize.width = self.view.frame.width * CGFloat(1+i)

            scrollView.addSubview(imageView)

        }


    }

//    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
//        return self.imageView
//    }

    
}

extension PictureVC : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = round(scrollView.contentOffset.x / self.view.frame.width)
        pageControl.currentPage = Int(CGFloat(currentPage))
    }

}
