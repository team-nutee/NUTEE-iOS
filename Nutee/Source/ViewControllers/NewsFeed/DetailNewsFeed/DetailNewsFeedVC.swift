//
//  detailNewsFeedVC.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/01/30.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class DetailNewsFeedVC: UIViewController {
    
    //MARK: - UI components
    
    @IBOutlet var replyTV: UITableView!
    
    // 댓글창 표시
    @IBOutlet var vwCommentWindow: UIView!
    @IBOutlet var txtvwComment: UITextView!
    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet var CommentWindowToBottom: NSLayoutConstraint!
    @IBOutlet var CommentToTrailing: NSLayoutConstraint!
    
    //MARK: - Variables and Properties
    
    var content: NewsPostsContentElement?
    var postId: Int?
    
    let statusNoReply = UIView()
    
    //MARK: - Dummy data
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        replyTV.delegate = self
        replyTV.dataSource = self
        
//        loadSelectedNewsFeed()
        
        txtvwComment.delegate = self
        
        // Register the custom header view
        let nibHead = UINib(nibName: "HeaderNewsFeedView", bundle: nil)
        self.replyTV.register(nibHead, forHeaderFooterViewReuseIdentifier: "HeaderNewsFeedView")
        
        initCommentWindow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // ---> NewsFeedVC에서 getPostService 실행 후 reloadData 실행 <--- //
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        addKeyboardNotification()
        
//        replyTV.reloadData()
    }

//MARK: - Helper

    func setStatusNoReplyView(_ cell: ReplyCell) {
        statusNoReply.backgroundColor = .white
        let maxWidthContainer: CGFloat = 375
        let maxHeightContainer: CGFloat = 140
        
        let zigiNoReply = UIImageView()
        zigiNoReply.image = #imageLiteral(resourceName: "zigi_no_reply")
        let maxWidthImage: CGFloat = 455
        let maxHeightImage: CGFloat = 684
        
        let msgLabel = UILabel()
        msgLabel.text = "댓글이 없습니다"
        msgLabel.textColor = .black
        msgLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 15)
        msgLabel.font = msgLabel.font.withSize(15)
        msgLabel.textAlignment = .center
        
        cell.addSubview(statusNoReply)
        statusNoReply.addSubview(zigiNoReply)
        statusNoReply.addSubview(msgLabel)
        
        statusNoReply.snp.makeConstraints({ (make) in
            make.width.equalTo(statusNoReply.snp.height).multipliedBy(maxWidthContainer/maxHeightContainer)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        })
        
        zigiNoReply.snp.makeConstraints({ (make) in
            make.width.equalTo(zigiNoReply.snp.height).multipliedBy(maxWidthImage/maxHeightImage)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(-30)
        })
        
        msgLabel.snp.makeConstraints({ (make) in
            make.centerX.equalTo(zigiNoReply)
            make.bottom.equalToSuperview()
        })
    }
    
    // 댓글창 밖에서 탭 하였을 때 키보드 내리기
    @IBAction func tapOutsideOfCommentWindow(_ sender: Any) {
        self.txtvwComment.endEditing(true)
    }
    
    @IBAction func btnSubmit(_ sender: Any) {
        postCommentService(postId: postId ?? 0, comment: txtvwComment.text, completionHandler: {() -> Void in
            self.txtvwComment.text = ""
            // 전송 버튼 가리기
            UIView.animate(withDuration: 0.1) {
                self.btnSubmit.alpha = 0
            }
            self.CommentToTrailing.constant = 5
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseInOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
            self.txtvwComment.endEditing(true)
            self.txtvwComment.translatesAutoresizingMaskIntoConstraints = true
            
            self.getPostService(postId: self.postId ?? 0, completionHandler: {(returnedData)-> Void in
                self.replyTV.reloadData()
                
                let lastRow = IndexPath(row: (self.content?.comments.count ?? 1) - 1, section: 0)
                self.replyTV.scrollToRow(at: lastRow, at: .bottom, animated: true)
            })
        })
        
    }
    
    func initCommentWindow() {
        txtvwComment.tintColor = .nuteeGreen
        
        // 시스템 Light or Dark 설정에 의한 댓글입력 창 배경색 설정
        txtvwComment.backgroundColor = .white
        txtvwComment.borderColor = .white

        // 댓글창 top부분과 table Cell의 경계 구분을 위한 shadow 효과 적용
        vwCommentWindow.layer.shadowOpacity = 0.7
        vwCommentWindow.layer.shadowOffset = CGSize(width: 3, height: 3)
        vwCommentWindow.layer.shadowRadius = 5.0
        vwCommentWindow.layer.shadowColor = UIColor.gray.cgColor
        
//        txtvwComment.placeholder = " 댓글을 입력하세요"
        if (txtvwComment.text == "") {
            textViewDidEndEditing(txtvwComment)
        }
    }

    // 해당 이용자의 light or dark 모드를 감지하는 함수
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        let userInterfaceStyle = traitCollection.userInterfaceStyle // Either .unspecified, .light, or .dark
        // Update your user interface based on the appearance
        switch userInterfaceStyle {
        case .light, .unspecified:
            txtvwComment.backgroundColor = UIColor.commentWindowLight
            txtvwComment.borderColor = UIColor.commentWindowLight
        case .dark:
            txtvwComment.backgroundColor = UIColor.commentWindowDark
            txtvwComment.borderColor = UIColor.commentWindowDark
        @unknown default:
            fatalError()
        }
    }
  
}

//MARK: - Build TableView

extension DetailNewsFeedVC : UITableViewDelegate { }

extension DetailNewsFeedVC : UITableViewDataSource {
    
    // HeaderView settings
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Dequeue with the reuse identifier
        let headerNewsFeed = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderNewsFeedView") as! HeaderNewsFeedView
        
        // HeaderView로 NewsFeedVC에서 받아온 게시글 정보룰 넘김
        headerNewsFeed.detailNewsPost = self.content
        headerNewsFeed.initPosting()
        
        // VC 컨트롤 권한을 HeaderView로 넘겨주기
        headerNewsFeed.detailNewsFeedVC = self
        
        // 사용자 프로필 이미지 탭 인식 설정
        headerNewsFeed.setClickActions()
        
        return headerNewsFeed
    }
    
    // TableView cell settings
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if content?.comments.count == 0 {
            if indexPath.row == 0 {
                return 0.5
            } else {
                return 220
            }
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if content?.comments.count == 0 {
            if indexPath.row == 0 {
                return 0.5
            } else {
                return 220
            }
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 생성한 댓글 cell 개수 파악
        var replyCnt = content?.comments.count ?? 0
        
        if replyCnt == 0 {
            // 보여줄 댓글이 없을 때
            replyCnt += 2
        } /*else {
            // 추가로 파악해야 할 대댓글의 개수
            for i in 0...(replyCnt - 1) {
                let reReply = content?.comments[i]
                replyCnt += reReply?.reComment?.count ?? 0
            }
        }*/
        
        return replyCnt
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Custom셀인 'ReplyCell' 형식으로 변환
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReplyCell", for: indexPath) as! ReplyCell
        
        cell.selectionStyle = .none
        
        if content?.comments.count == 0 {
            if indexPath.row == 0 {
                cell.backgroundColor = .lightGray
            } else {
                setStatusNoReplyView(cell)
                statusNoReply.isHidden = false
                cell.contentsCell.isHidden = true
                tableView.separatorStyle = .none
            }
        } else {
            // 불러올 댓글이 있는 경우 cell 초기화 진행
            cell.contentsCell.isHidden = false
            statusNoReply.isHidden = true
            // emptyStatusView(tag: 404)를 cell에서 제거하기
            if let viewWithTag = self.view.viewWithTag(404) {
                viewWithTag.removeFromSuperview()
            }
            
            // 생성된 Cell클래스로 comment 정보 넘겨주기
            cell.comment = content?.comments[indexPath.row]
            cell.initComments()
            
            // VC 컨트롤 권한을 Cell클래스로 넘겨주기
            cell.detailNewsFeedVC = self
            
            // 댓글 사용자 이미지 탭 인식 설정
            cell.setClickActions()
            
            // 대댓글 관련 replyCell 설정
//            if cell.comment?.reComment?.count != 0 {
//                replyTV.beginUpdates()
//                print("insertRow 함수 실행")
////                let indextPath = IndexPath(row: indexPath.row, section: 0)
//                replyTV.insertRows(at: [indexPath], with: .automatic)
//                replyTV.endUpdates()
//            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    // tableView의 마지막 cell 밑의 여백 발생 문제(footerView의 기본 높이 값) 제거 코드
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    // 댓글을 오른쪽(trailing)에서 왼쪽으로 스와이프(swipe) 하였을 때 보여줄 항목 설정(댓글 수정, 삭제 기능)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let comment = content?.comments[indexPath.row]
        
        if comment?.user.id == UserDefaults.standard.integer(forKey: "id") {
            // 자기 댓글을 스와이프 했을때
            let editAction = UIContextualAction(style: .normal, title:  "수정", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                
                // Call edit action
                
                // Reset state
                
                success(true)
            })

            let deleteAction = UIContextualAction(style: .destructive, title:  "삭제", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                let deleteAlert = UIAlertController(title: nil, message: "댓글을 삭제 하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
                let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
                let okAction = UIAlertAction(title: "삭제", style: .destructive) {
                    (action: UIAlertAction) in
                    // Code to delete
                    self.deleteCommentService(postId: comment?.postID ?? 0, commentId: comment?.id ?? 0, completionHandler: {()-> Void in
                        self.getPostService(postId: self.postId ?? 0, completionHandler: {(returnedData)-> Void in
                            self.replyTV.reloadData()
                        })
                    })
                }
                deleteAlert.addAction(cancelAction)
                deleteAlert.addAction(okAction)
                self.present(deleteAlert, animated: true, completion: nil)
                
                success(true)
            })
            
            return UISwipeActionsConfiguration(actions:[deleteAction,editAction])
        } else {
            // 다른 사람 댓글을 스와이프 했을때
            let reportAction = UIContextualAction(style: .destructive, title:  "신고", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                
                // Code to 신고 기능
                let reportAlert = UIAlertController(title: "🚨댓글 신고🚨", message: "", preferredStyle: UIAlertController.Style.alert)
                let cancelAction
                    = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                let reportAction = UIAlertAction(title: "신고", style: .destructive) {
                    (action: UIAlertAction) in
                    let reason = reportAlert.textFields?[0].text ?? "" // 신고 내용
                    self.reportCommentService(reportReason: reason)
                    //신고 여부 알림 <-- 서버연결 코드에서 구현됨
                }
                reportAlert.addTextField { (mytext) in
                    mytext.tintColor = .nuteeGreen
                    mytext.placeholder = "신고할 내용을 입력해주세요."
                }
                reportAlert.addAction(cancelAction)
                reportAlert.addAction(reportAction)
                
                self.present(reportAlert, animated: true, completion: nil)
                
                
                success(true)
            })
            
            return UISwipeActionsConfiguration(actions:[reportAction])
        }
        
        
    }
    
}

// MARK: - Reply KeyBoard PopUp

extension DetailNewsFeedVC {
 
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
            let tabbarHeight = self.tabBarController?.tabBar.frame.size.height ?? 0
            //            let safeBottomHeight = self.view.bottomAnchor
            _ = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first

//            let window = UIApplication.shared.keyWindow
//            let bottomPadding = window?.safeAreaInsets.bottom
            
            if CommentWindowToBottom.constant == 0 {
                CommentWindowToBottom.constant -= (keyboardHeight - tabbarHeight)
            }
//            CommentWindowToBottom.constant = -300
//            replyTV.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
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
            
            CommentWindowToBottom.constant = 0
            replyTV.contentInset = .zero
            self.view.setNeedsLayout()
            UIView.animate(withDuration: duration, delay: 0, options: .init(rawValue: curve), animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.txtvwComment.endEditing(true)
    }
    
}

// MARK: - Detect commentWindow text changed
extension DetailNewsFeedVC: UITextViewDelegate {
    
    public func textViewDidChange(_ textView: UITextView) {
        // 입력된 빈칸과 줄바꿈 개수 구하기
        var str = txtvwComment.text.replacingOccurrences(of: " ", with: "")
        str = str.replacingOccurrences(of: "\n", with: "")
        // 빈칸이나 줄바꿈으로만 입력된 경우 버튼 비활성화
        if str.count != 0 {
            // 전송 버튼 보이기
            UIView.animate(withDuration: 0.2) {
                self.btnSubmit.alpha = 1.0
            }
            self.CommentToTrailing.constant = 40
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        } else {
            // 전송 버튼 가리기
            UIView.animate(withDuration: 0.1) {
                self.btnSubmit.alpha = 0
            }
            self.CommentToTrailing.constant = 5
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseInOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }

        // 댓글 입력창의 높이가 100 이상 넘을 시 스크롤 가능 활성화
        if txtvwComment.contentSize.height >= 100 {
            txtvwComment.isScrollEnabled = true
        } else {
            txtvwComment.frame.size.height = txtvwComment.contentSize.height
            txtvwComment.isScrollEnabled = false
        }
        
        // 입력된 줄바꿈 개수 구하기
        let originalStr = txtvwComment.text.count
        let removeEnterStr = txtvwComment.text.replacingOccurrences(of: "\n", with: "").count
        // 엔터가 4개 이하 일시 댓글창 높이 자동조절 설정
        let enterNum = originalStr - removeEnterStr
        if enterNum <= 4 {
            self.txtvwComment.translatesAutoresizingMaskIntoConstraints = false
        } else {
            self.txtvwComment.translatesAutoresizingMaskIntoConstraints = true
        }
    }

    
    // PlaceHolder 따로 지정해주기(기존 것 사용시 충돌 일어남)
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text == "") {
            textView.text = " 댓글을 입력하세요"
            textView.textColor = UIColor.lightGray
        }
        textView.resignFirstResponder()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView){
        if (txtvwComment.text == " 댓글을 입력하세요"){
            textView.text = ""
            textView.textColor = UIColor.black
        }
        textView.becomeFirstResponder()
    }
    
}

// MARK: - 서버 연결 코드 구간

extension DetailNewsFeedVC {

    // 게시글 한 개 가져오기
    func getPostService(postId: Int, completionHandler: @escaping (_ returnedData: NewsPostsContentElement) -> Void ) {
        ContentService.shared.getPost(postId) { responsedata in
            
            switch responsedata {
            case .success(let res):
                let response = res as! NewsPostsContentElement
                self.content = response
                print("newsPost server connect successful")
                
                completionHandler(self.content!)
                
            case .requestErr(_):
                print("request error")
            
            case .pathErr:
                print(".pathErr")
            
            case .serverErr:
                print(".serverErr")
            
            case .networkFail :
                print("failure")
                }
        }
    }
    
    // MARK: - 댓글 작성
    
    func postCommentService(postId: Int, comment: String, completionHandler: @escaping () -> Void ) {
        ContentService.shared.commentPost(postId, comment: comment) { (responsedata) in
            
            switch responsedata {
            case .success(let res):
                completionHandler()
                
                print("commentPost succussful", res)
            case .requestErr(_):
                print("request error")
            
            case .pathErr:
                print(".pathErr")
            
            case .serverErr:
                print(".serverErr")
            
            case .networkFail :
                print("failure")
                }
        }
    }
    
    // 뎃글 신고 <-- 확인 필요
    func reportCommentService(reportReason: String) {
        let userid = UserDefaults.standard.string(forKey: "id") ?? "" // <-- 수정 必
        ContentService.shared.reportPost(userid, reportReason) { (responsedata) in // <-- 현재 작성된 API는 게시글(post)에 대한 신고기능
            
            switch responsedata {
            case .success(let res):
                
                print(res)
                
                let successfulAlert = UIAlertController(title: "신고가 완료되었습니다", message: nil, preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                
                successfulAlert.addAction(okAction)
                
                self.present(successfulAlert, animated: true, completion: nil)

            case .requestErr(_):
                print("request error")
            
            case .pathErr:
                print(".pathErr")
            
            case .serverErr:
                print(".serverErr")
            
            case .networkFail :
                print("failure")
                }
        }
    }
    
    // 댓글 삭제
    func deleteCommentService(postId: Int, commentId: Int, completionHandler: @escaping () -> Void ) {
        ContentService.shared.commentDelete(postId, commentId: commentId) { (responsedata) in
            
            switch responsedata {
            case .success(let res):
                
                print("commentDelete succussful", res)
                completionHandler()
                print(res)
            case .requestErr(_):
                let errorAlert = UIAlertController(title: "오류발생😵", message: "오류가 발생하여 댓글을 삭제하지 못했습니다", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                
                errorAlert.addAction(okAction)
                
                self.present(errorAlert, animated: true, completion: nil)
                
                print("request error")
            
            case .pathErr:
                print(".pathErr")
            
            case .serverErr:
                print(".serverErr")
            
            case .networkFail :
                print("failure")
                }
        }
    }
    
}
