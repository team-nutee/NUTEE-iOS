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
    
    @IBOutlet var imgUserImg: UIImageView!
    @IBOutlet var lblUserId: UILabel!
    @IBOutlet var lblPostTime: UILabel!
    @IBOutlet var cvPostImg: UICollectionView!
    @IBOutlet var lblContents: UILabel!
    @IBOutlet var btnRepost: UIButton!
    @IBOutlet var btnLike: UIButton!
    @IBOutlet var btnComment: UIButton!
    

    //MARK: - Variables and Properties
    
    let dataPeng = ["sample_peng01.jepg", "sample_peng02.jepg", "sample_peng03.png", "sample_peng04.png", "sample_peng05.png"]
    
    var numLike = 0
    var numRepost = 0
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
        
        cvPostImg.delegate = self
        cvPostImg.dataSource = self
        cvPostImg.reloadData()
        
        initPosting()
    }
    
    //MARK: - Clicked Action
    
    @IBAction func btnRepost(_ sender: UIButton) {
        // .selected State를 활성화 하기 위한 코드
        btnRepost.isSelected = !btnRepost.isSelected
        if isClickedRepost {
            numRepost -= 1
            setButtonAttributed(btn: sender, num: numRepost, color: .gray, state: .normal)
            isClickedRepost = false
        } else {
            numRepost += 1
            setButtonAttributed(btn: sender, num: numRepost, color: .nuteeGreen, state: .selected)
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
//            sender.setImage(UIImage(named: "heart"), for: .normal)
            isClickedLike = false
        } else {
//            btnLike.isSelected = true
            numLike += 1
            setButtonAttributed(btn: sender, num: numLike, color: .systemPink, state: .selected)
//            sender.setImage(UIImage(named: "heart-filled"), for: .normal)
            isClickedLike = true
        }
    }
    
    @IBAction func btnComment(_ sender: UIButton) {
        
        /*
        btnComment.isSelected = !btnComment.isSelected
        if isClickedComment {
            numComment -= 1
            setButtonPlain(btn: sender, num: numComment, color: .gray, state: .normal)
            isClickedComment = false
        } else {
            numComment += 1
            btnComment.setTitle(" " + String(numComment), for: .selected)
            btnComment.tintColor = .blue
            btnComment.setTitleColor(.blue, for: .selected)
            isClickedComment = true
        }
        */
    }
        
    //MARK: - Helper
    
    //포스팅 내용 초기설정
    func initPosting() {
        imgUserImg.image = #imageLiteral(resourceName: "defaultProfile")
        imgUserImg.setRounded(radius: nil)
        
        lblContents.text = "Hi~"
//        imgvwPostImg.image = #imageLiteral(resourceName: "nutee_zigi")
        
        //버튼모양 초기 설정
        setButtonAttributed(btn: btnLike, num: numLike, color: .gray, state: .normal)
        setButtonAttributed(btn: btnRepost, num: numRepost, color: .gray, state: .normal)
        setButtonPlain(btn: btnComment, num: numComment, color: .gray, state: .normal)
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
extension NewsFeedCell: UICollectionViewDelegateFlowLayout {

    // SIZE FOR COLLECTION VIEW CELL
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let padding: CGFloat =  10
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize / 2, height: collectionView.frame.height)
//        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

}
