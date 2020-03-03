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
    
    //MARK: - Variables and Properties
    
    var contentId : Int = 0
    var content : PostContent?

    var indexPath = 0
    
    //MARK: - Dummy data
    
    var userInfo : SignIn?
    var test : [String] = ["","","",""]
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        replyTV.delegate = self
        replyTV.dataSource = self
        
//        loadSelectedNewsFeed()
        
        // Register the custom header view
        let nibHead = UINib(nibName: "HeaderNewsFeedView", bundle: nil)
        self.replyTV.register(nibHead, forHeaderFooterViewReuseIdentifier: "HeaderNewsFeedView")
        
        initCommentWindow()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        addKeyboardNotification()
    }

//MARK: - Helper

    // 댓글창 밖에서 탭 하였을 때 키보드 내리기
    @IBAction func tapOutsideOfCommentWindow(_ sender: Any) {
        self.txtvwComment.endEditing(true)
    }
    
    @IBAction func btnSubmit(_ sender: Any) {
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
        
        txtvwComment.placeholder = " 댓글을 입력하세요"
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
    
    //HeaderView settings
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Dequeue with the reuse identifier
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderNewsFeedView")
//        cell.detailNew = self
//        cell.indexPath = self.indexPath
        
        return cell
    }
    
    //TableView cell settings
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return test.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Custom셀인 'ReplyCell' 형식으로 변환
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReplyCell", for: indexPath) as! ReplyCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 댓글은 \(indexPath.row) 번쨰 댓글입니다")
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

//MARK: - UserInfo 서버 연결을 위한 Service 실행 구간

extension DetailNewsFeedVC {
    func getPostContentInfoService() {
        ContentService.shared.getPost(contentId) { responsedata in

            switch responsedata {
            case .success(let res):
                self.content = res as? PostContent
                
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
