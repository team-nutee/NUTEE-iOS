//
//  NewsFeedTableHeaderSection.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/02/03.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class NewsFeedTableHeaderSection: UITableViewHeaderFooterView {
    
    weak var detailNewsFeedVC: UIViewController?
    
    // User Information
    @IBOutlet var imgvwUserImg: UIImageView!
    @IBOutlet var lblUserId: UILabel!
    @IBOutlet var lblPostTime: UILabel!
    
    // Posting
    @IBOutlet var txtvwConetents: UITextView!
    
    // ver. TwoFrame
    @IBOutlet var vwTwo: UIView!
    @IBOutlet var imgvwTwo: [UIImageView]!
    @IBOutlet var lblTwoMoreImg: UILabel!

    //앨범 프레임 three, four 버전을 통합관리 할 view 객체 생성
    @IBOutlet var vwSquare: UIView!
    // ver. ThreeFrame
    @IBOutlet var vwThree: UIView!
    @IBOutlet var imgvwThree: [UIImageView]!
    @IBOutlet var lblThreeMoreImg: UILabel!
    // ver. FourFrame
    @IBOutlet var vwFour: UIView!
    @IBOutlet var imgvwFour: [UIImageView]!
    @IBOutlet var lblFourMoreImg: UILabel!
    
    // function buttons
    @IBOutlet var btnRepost: UIButton!
    @IBOutlet var btnLike: UIButton!
    @IBOutlet var btnComment: UIButton!
    @IBOutlet var btnMore: UIButton!
    
    //MARK: - Variables and Properties
    
    let dataPeng = ["sample_peng01.jepg", "sample_peng02.jepg", "sample_peng03.png", "sample_peng04.png", "sample_peng05.png"]
    
    var numLike = 0
    var numComment = 0
    
    var isClickedLike: Bool = false
    var isClickedRepost: Bool = false
    var isClickedComment: Bool = false
    
    //MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initPosting()
    }
    
    //MARK: - Helper

    @IBAction func btnRepost(_ sender: UIButton) {
        // .selected State를 활성화 하기 위한 코드
        btnRepost.isSelected = !btnRepost.isSelected
        if isClickedRepost {
            btnRepost.tintColor = .nuteeGreen
            isClickedRepost = false
        } else {
            btnRepost.tintColor = .gray
            isClickedRepost = true
        }
    }
            
    @IBAction func btnLike(_ sender: UIButton) {
        // .selected State를 활성화 하기 위한 코드
        btnLike.isSelected = !btnLike.isSelected
        if isClickedLike {
//            btnLike.isSelected = false
            numLike -= 1
            setButtonAttributed(btn: sender, num: numLike, color: .gray, state: .normal)
//            sender.setImage(UIImage(named: "heart.filled"), for: .selected)
            isClickedLike = false
        } else {
//            btnLike.isSelected = true
            numLike += 1
            setButtonAttributed(btn: sender, num: numLike, color: .systemPink, state: .selected)
//            sender.setImage(UIImage(named: "heart.fill"), for: .selected)

            isClickedLike = true
        }
    }
    
    @IBAction func btnMore(_ sender: Any) {
        let moreAlert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let editAction = UIAlertAction(title: "수정", style: .default){
            (action: UIAlertAction) in
            // Code to edit
        }
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) {
            (action: UIAlertAction) in
            // Code to delete
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        moreAlert.addAction(editAction)
        moreAlert.addAction(deleteAction)
        moreAlert.addAction(cancelAction)
//        self.present(moreAlert, animated: true, completion: nil)
    }
    
    func initPosting() {
        imgvwUserImg.image = #imageLiteral(resourceName: "defaultProfile")
        imgvwUserImg.setRounded(radius: nil)
        
        txtvwConetents.text = "ㅇㄴ머라ㅕ랴ㅐ듀ㅐ듀ㅠㅜLorem ipsum dolor sit er elit lamet, consectetaur cillium 이 글이 보이면 전부가 출력된 것입니다."
        txtvwConetents.postingInit()
        
        vwTwo.isHidden = true
//        vwSquare.isHidden = true
        
        var num = 0
        switch num {
        case 0:
            // ver. TwoFrame
            vwTwo.isHidden = false
            for imgvw in imgvwTwo {
                imgvw.image = UIImage(named: dataPeng[num])
                if num == 1 {
                    let leftImg = dataPeng.count - 2
                    if leftImg > 0 {
                        imgvw.alpha = 0.5
                        lblTwoMoreImg.text = String(leftImg) + " +"
                        lblTwoMoreImg.sizeToFit()
                    } else {
                        lblTwoMoreImg.isHidden = true
                    }
                }
                num += 1
            }
        /*case 1:
            // ver. ThreeFrame
            vwSquare.isHidden = false
            vwFour.isHidden = true
            for imgvw in imgvwThree {
                imgvw.image = UIImage(named: dataPeng02[num])
                if num == 2 {
                    imgvw.alpha = 0.5
                    let leftImg = dataPeng02.count - 3
                    lblThreeMoreImg.text = String(leftImg) + " +"
                }
                num += 1
            }
        case 2:
            // ver. FourFrame
            vwSquare.isHidden = false
            vwThree.isHidden = true
            for imgvw in imgvwFour {
                imgvw.image = UIImage(named: dataPeng04[num])
                if num == 3 {
                    imgvw.alpha = 0.5
                    let leftImg = dataPeng04.count - 4
                    lblFourMoreImg.text = String(leftImg) + " +"
                }
                num += 1
            }*/
        default:
            // ver. TwoFrame
            vwTwo.isHidden = true
            for imgvw in imgvwTwo {
                imgvw.image = UIImage(named: dataPeng[num])
                if num == 1 {
                    let leftImg = dataPeng.count - 2
                    if leftImg > 0 {
                        imgvw.alpha = 0.5
                        lblTwoMoreImg.text = String(leftImg) + " +"
                    }
                }
                num += 1
            }
        }
        
        btnRepost.tintColor = .gray
        setButtonAttributed(btn: btnLike, num: numLike, color: .gray, state: .normal)
        setButtonPlain(btn: btnComment, num: numComment, color: .gray, state: .normal)
        btnMore.tintColor = .gray
    }
    
    func setButtonPlain(btn: UIButton, num: Int, color: UIColor, state: UIControl.State) {
        btn.setTitle(" " + String(num), for: state)
        btnComment.tintColor = color
        btnComment.setTitleColor(color, for: state)
    }
    
    func setButtonAttributed(btn: UIButton, num: Int, color: UIColor, state: UIControl.State) {
        let stateAttributes = [NSAttributedString.Key.foregroundColor: color]
        btn.setAttributedTitle(NSAttributedString(string: " " + String(num), attributes: stateAttributes), for: state)
        btn.tintColor = color
    }
}

// MARK: - Collection View
//Posting된 이미지를 표시해 주는 CollectionView에 대한 기능구현

extension NewsFeedTableHeaderSection: UICollectionViewDelegate { }

extension NewsFeedTableHeaderSection: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataPeng.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostImgCollectionCell", for: indexPath) as! PostImgCVCell
        
        cell.imgvwPost.image = UIImage(named: dataPeng[indexPath.row])
        
        
        return cell
    }

    /*
    //이미지에 tab 제스쳐 기능 설정
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! FullScreenImgCVCell
        self.imageTapped(image: cell.problemImage.image!)
    }
    
    //이미지 클릭 시 전환 코드구현 구간
    func imageTapped(image:UIImage){
        let newImageView = UIImageView(image: image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }

    //이미지 전체화면 종료
    func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
 */
 
}

//CollectionView의 Cell에 대한 크기를 조정시켜 주는 Delegate
extension NewsFeedTableHeaderSection: UICollectionViewDelegateFlowLayout {

    // SIZE FOR COLLECTION VIEW CELL
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let padding: CGFloat =  10
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize / 2, height: collectionView.frame.height)
//        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

}
