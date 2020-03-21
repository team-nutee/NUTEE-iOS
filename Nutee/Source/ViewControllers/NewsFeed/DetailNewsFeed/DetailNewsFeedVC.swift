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
    
    @IBOutlet var statusNoReply: UIView!
    
    // 댓글창 표시
    @IBOutlet var vwCommentWindow: UIView!
    @IBOutlet var txtvwComment: UITextView!
    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet var CommentWindowToBottom: NSLayoutConstraint!
    @IBOutlet var CommentToTrailing: NSLayoutConstraint!
    
    //MARK: - Variables and Properties
    
    var content: NewsPostsContentElement?
    var postId: Int?
    
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

    // 댓글창 밖에서 탭 하였을 때 키보드 내리기
    @IBAction func tapOutsideOfCommentWindow(_ sender: Any) {
        self.txtvwComment.endEditing(true)
    }
    
    @IBAction func btnSubmit(_ sender: Any) {
        commentPostService(postId: postId ?? 0, comment: txtvwComment.text, completionHandler: {() -> Void in
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
        // 시스템 Light or Dark 설정에 의한 댓글입력 창 배경색 설정
        if self.traitCollection.userInterfaceStyle == .light {
            txtvwComment.backgroundColor = UIColor.commentWindowLight
            txtvwComment.borderColor = UIColor.commentWindowLight
        } else {
            txtvwComment.backgroundColor = UIColor.commentWindowDark
            txtvwComment.borderColor = UIColor.commentWindowDark
        }

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
                cell.addSubview(statusNoReply)
                statusNoReply.isHidden = false
                cell.contentsCell.isHidden = true
                tableView.separatorStyle = .none
            }
        } else {
            // 불러올 댓글이 있는 경우 cell 초기화 진행
            cell.contentsCell.isHidden = false
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
//        NSLog("선택된 댓글은 \(indexPath.row) 번쨰 댓글입니다")
    }
    
    // tableView의 마지막 cell 밑의 여백 발생 문제(footerView의 기본 높이 값) 제거 코드
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
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

//MARK: - 게시글 하나를 가져오기 위한 서버연결
extension DetailNewsFeedVC {
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
    
    // MARK: - comment
    
    func commentPostService(postId: Int, comment: String, completionHandler: @escaping () -> Void ) {
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
}
