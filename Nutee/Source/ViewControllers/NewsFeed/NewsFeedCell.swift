//
//  NewsFeedVO.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/01/14.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class NewsFeedCell: UITableViewCell {
    
    //MARK: - UI components
    
    weak var newsFeedVC: UIViewController?
    
    // User Information
    @IBOutlet var imgUserImg: UIImageView!
    @IBOutlet var lblUserId: UILabel!
    @IBOutlet var lblPostTime: UILabel!
    
    // Posting
    @IBOutlet var txtvwContents: UITextView!
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
    

    //MARK: - Variables and Properties
    
    var indexPath = 0
    let dataPeng02 = [ "sample_peng01.jepg", "sample_peng02.jepg" ]
    let dataPeng03 = [ "sample_peng01.jepg", "sample_peng02.jepg", "sample_peng03.png" ]
    let dataPeng04 = [ "sample_peng01.jepg", "sample_peng02.jepg", "sample_peng03.png", "sample_peng04.png" ]
    let dataPeng05 = [ "sample_peng01.jepg", "sample_peng02.jepg", "sample_peng03.png", "sample_peng04.png", "sample_peng05.png" ]
    
    var numLike = 0
    var numComment = 0
    
    var isClickedLike: Bool = false
    var isClickedRepost: Bool = false
    var isClickedComment: Bool = false
    
    // .normal 상태에서의 버튼 AttributedStringTitle의 색깔 지정
    let normalAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
    // .selected 상태에서의 Repost버튼 AttributedStringTitle의 색깔 지정
    let selectedRepostAttributes = [NSAttributedString.Key.foregroundColor: UIColor.nuteeGreen]
    // .selected 상태에서의 Like버튼 AttributedStringTitle의 색깔 지정
    let selectedLikeAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemPink]
    
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
    
    @IBAction func btnComment(sender: Any) {
        showDetailNewsFeed()
        
    }
    
    //수정, 삭제 알림창 기능
    @IBAction func btnMore(sender: AnyObject) {
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
        newsFeedVC?.present(moreAlert, animated: true, completion: nil)
    }
    
    //포스팅 내용 초기설정
    func initPosting() {
        imgUserImg.image = #imageLiteral(resourceName: "defaultProfile")
        imgUserImg.setRounded(radius: nil)
        
        lblUserId.text = "testUserIDcheck"
        lblUserId.sizeToFit()
        
        // Posting 내용 초기설정
        txtvwContents.text = String("Before some words beginning with a pronounced (not silent) h in an unstressed first syllable, such as historic(al), hallucination, hilarious, horrendous, and horrific, some (especially older) British writers prefer to use an over a (an historical event, etc.).[7] An is also prefBritish English, American English typically uses an before herb, since the h in this word is silent for most Americans. The correct usage in respect of the term was the subject of an amendment debated in the UK Parliament.")
        txtvwContents.postingInit()
        showImgFrame()
        
        //버튼모양 초기 설정
        btnRepost.tintColor = .gray
        setButtonAttributed(btn: btnLike, num: numLike, color: .gray, state: .normal)
        setButtonPlain(btn: btnComment, num: numComment, color: .gray, state: .normal)
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

    //이미지 클릭 시 전환 코드구현 구간
    func imageTapped(image:UIImage){
        let newImageView = UIImageView(image: image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        newsFeedVC?.view.addSubview(newImageView)
        newsFeedVC?.navigationController?.isNavigationBarHidden = true
        newsFeedVC?.tabBarController?.tabBar.isHidden = true
    }

    //이미지 전체화면 종료
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        newsFeedVC?.navigationController?.isNavigationBarHidden = false
        newsFeedVC?.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
    func showDetailNewsFeed() {
        let detailNewsFeedSB = UIStoryboard(name: "DetailNewsFeed", bundle: nil)
        let showDetailNewsFeedVC = detailNewsFeedSB.instantiateViewController(withIdentifier: "DetailNewsFeed") as! DetailNewsFeedVC
        //DetailNewsFeedVC로 NewsFeedVC의 선택된 cell의 indexPath값 전달
        showDetailNewsFeedVC.indexPath = self.indexPath
        newsFeedVC?.navigationController?.pushViewController(showDetailNewsFeedVC, animated: true)
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

/*
// MARK: - Collection View
//Posting된 이미지를 표시해 주는 CollectionView에 대한 기능구현

extension NewsFeedCell: UICollectionViewDelegate { }

extension NewsFeedCell: UICollectionViewDataSource {

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
//        let cell = collectionView.cellForItem(at: indexPath) as! FullScreenImgCVCell
//        self.imageTapped(image: cell.imgvwFullScreen.image!)
        showDetailNewsFeed()
//        imageTapped(image: imgUserImg.image!)
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
        newsFeedVC?.view.addSubview(newImageView)
        newsFeedVC?.navigationController?.isNavigationBarHidden = true
        newsFeedVC?.tabBarController?.tabBar.isHidden = true
    }

    //이미지 전체화면 종료
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        newsFeedVC?.navigationController?.isNavigationBarHidden = false
        newsFeedVC?.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
 
 
}

//CollectionView의 Cell에 대한 크기를 조정시켜 주는 Delegate
extension NewsFeedCell: UICollectionViewDelegateFlowLayout {

    // SIZE FOR COLLECTION VIEW CELL
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let padding: CGFloat =  10
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize / 2, height: collectionView.frame.height)
//        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

}
*/
