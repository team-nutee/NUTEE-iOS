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
    @IBOutlet var ContentsToRepost: NSLayoutConstraint!
    
    // ver. TwoFrame
    @IBOutlet var vwTwo: UIView!
    @IBOutlet var imgvwTwo: [UIImageView]!
    @IBOutlet var lblTwoMoreImg: UILabel!
    @IBOutlet var vwTwoToRepost: NSLayoutConstraint!

    //앨범 프레임 three, four 버전을 통합관리 할 view 객체 생성
    @IBOutlet var vwSquare: UIView!
    @IBOutlet var vwSquareToRepost: NSLayoutConstraint!
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
    
    var indexPath = 1
    let dataPeng02 = [ "sample_peng01.jepg", "sample_peng02.jepg" ]
    let dataPeng03 = [ "sample_peng01.jepg", "sample_peng02.jepg", "sample_peng03.png" ]
    let dataPeng04 = [ "sample_peng01.jepg", "sample_peng02.jepg", "sample_peng03.png", "sample_peng04.png" ]
    let dataPeng05 = [ "sample_peng01.jepg", "sample_peng02.jepg", "sample_peng03.png", "sample_peng04.png", "sample_peng05.png" ]
    
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
        
        lblUserId.text = "Crossroads"
        lblUserId.sizeToFit()
        
        txtvwConetents.text = "서울 한강에 나타난 괴생물체에 맞선 한 가족의 사투를 그리고 있다. 당시 최고의 첨단 기술력으로 구현한 한국 괴수영화의 시작, 사회비판과 풍자를 녹여낸 정점의 블랙 코미디다. 이전 문회사 '웨타 디지털(Weta Digita)'과 작업했다. 마감 시한을 맞추기 위해 서두른 후, 영화는풍자를 녹여낸 정점의 블랙 코미디다. 이전 문회사 '웨타 디지털(Weta Digita)'과 작업했다. 마감 시한을 맞추기 위해 서두른 후, 영화는풍자를 녹여낸 정점의 블랙 코미디다. 이전 문회사 '웨타 디지털(Weta Digita)'과 작업했다. 마감 시한을 맞추기 위해 서두른 후, 영화는풍자를 녹여낸 정점의 블랙 코미디다. 이전 문회사 '웨타 디지털(Weta Digita)'과 작업했다. 마감 시한을 맞추기 위해 서두른 후, 영화는 2006년 칸 국제 영화제의문에 초청되었다.이 글이 보이면 전부가 출력된 것입니다."
        txtvwConetents.postingInit()
        showImgFrame()
        
        //버튼모양 초기 설정
        btnRepost.tintColor = .gray
        setButtonAttributed(btn: btnLike, num: numLike, color: .gray, state: .normal)
        setButtonPlain(btn: btnComment, num: numComment, color: .gray, state: .normal)
        btnMore.tintColor = .gray
    }

    // 사진 개수에 따른 이미지 표시 유형 선택
    func showImgFrame() {
        //constrain layout 충돌 방지를 위한 이미지 뷰 전체 hidden 설정 <-- 실패
        vwTwo.isHidden = true
        vwSquare.isHidden = true
        
        var num = 0
        switch indexPath {
        case 0:
            // ver. TwoFrame
            vwTwo.isHidden = false
            
            vwTwoToRepost.isActive = true
            vwSquareToRepost.isActive = false
            ContentsToRepost.isActive = false
            
            for imgvw in imgvwTwo {
                imgvw.image = UIImage(named: dataPeng03[num])
                if num == 1 {
                    let leftImg = dataPeng03.count - 2
                    if leftImg > 0 {
                        imgvw.alpha = 0.8
                        lblTwoMoreImg.isHidden = false
                        lblTwoMoreImg.text = String(leftImg) + " +"
                        lblTwoMoreImg.sizeToFit()
//                        imageTapped(image: imgvw.image!)
                    } else {
                        lblTwoMoreImg.isHidden = true
                    }
                }
                num += 1
            }
        case 1:
            // ver. ThreeFrame
            vwSquare.isHidden = false
            vwFour.isHidden = true
            
            vwTwoToRepost.isActive = false
            vwSquareToRepost.isActive = true
            ContentsToRepost.isActive = false
            
            for imgvw in imgvwThree {
                imgvw.image = UIImage(named: dataPeng05[num])
                if num == 2 {
                    let leftImg = dataPeng05.count - 3
                    if leftImg > 0 {
                        imgvw.alpha = 0.8
//                        lblThreeMoreImg.isHidden = false
                        lblThreeMoreImg.text = String(leftImg) + " +"
                        lblThreeMoreImg.sizeToFit()
                    } else {
                        lblThreeMoreImg.isHidden = true
                    }
                }
                num += 1
            }
        case 2:
            // ver. FourFrame
            vwSquare.isHidden = false
            vwThree.isHidden = true
            
            vwTwoToRepost.isActive = false
            vwSquareToRepost.isActive = true
            ContentsToRepost.isActive = false
            
            for imgvw in imgvwFour {
                imgvw.image = UIImage(named: dataPeng04[num])
                if num == 3 {
                    let leftImg = dataPeng04.count - 4
                    if leftImg > 0 {
                        imgvw.alpha = 0.8
//                        lblTwoMoreImg.isHidden = false
                        lblFourMoreImg.text = String(leftImg) + " +"
                        lblFourMoreImg.sizeToFit()
                    } else {
                        lblFourMoreImg.isHidden = true
                    }
                }
                num += 1
            }
        default:
            // 보여줄 사진이 없는 경우(글만 표시)
            lblTwoMoreImg.isHidden = true
            lblThreeMoreImg.isHidden = true
            lblFourMoreImg.isHidden = true
            
            vwTwoToRepost.isActive = false
            vwSquareToRepost.isActive = false
            ContentsToRepost.isActive = true
        } // case문 종료
    } // <---ShowImageFrame 설정 끝
    
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

/*
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
*/