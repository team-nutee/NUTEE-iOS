//
//  UIViewController+Extension.swift
//  Nutee
//
//  Created by Junhyeon on 2020/01/24.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

extension UIViewController {
    
    
    // 2칸인 alert title - up, message - down
    func simpleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "확인", style: .default) { (action) in
            
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    // 예 버튼을 누를때 핸들러로 핸들링하는 Alert with cancel
    func simpleAlertWithHandler(title: String, msg: String?, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "예", style: .cancel, handler: handler)
        let noAction = UIAlertAction(title: "아니오", style: .default)
        
        alert.addAction(noAction)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    func oneAlertWithHandler(title: String, msg: String?, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "예", style: .cancel, handler: handler)
        
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    // 예 버튼을 누를때 핸들러로 핸들링하는 Alert without cancel
    func simpleDismissAlert(title: String, msg: String, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "예", style: .cancel, handler: handler)
        alert.addAction(okAction)
        
        self.present(alert, animated: true)
    }
    
//  MARK: - TODO actionBtn 코드 단순화
//    func actionSheetAlert(_ RootVC: UIViewController){
//        let moreAlert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
//        let editAction = UIAlertAction(title: "수정", style: .default){
//            (action: UIAlertAction) in
//            // Code to edit
//        }
//        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) {
//            (action: UIAlertAction) in
//            let deleteAlert = UIAlertController(title: nil, message: "삭제하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
//            let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
//            let okAction = UIAlertAction(title: "확인", style: .default) {
//                (action: UIAlertAction) in
//                // Code to delete
//            }
//            deleteAlert.addAction(cancelAction)
//            deleteAlert.addAction(okAction)
//            RootVC.present(deleteAlert, animated: true, completion: nil)
//        }
//        let userReportAction = UIAlertAction(title: "신고하기🚨", style: .destructive) {
//            (action: UIAlertAction) in
//            // Code to 신고 기능
//            let reportAlert = UIAlertController(title: "이 게시글을 신고하시겠습니까?", message: "", preferredStyle: UIAlertController.Style.alert)
//            let cancelAction
//                = UIAlertAction(title: "취소", style: .cancel, handler: nil)
//            let reportAction = UIAlertAction(title: "신고", style: .destructive) {
//                (action: UIAlertAction) in
//                // <---- 신고 기능 구현
//                let content = reportAlert.textFields?[0].text ?? "" // 신고 내용
//
//                reportPost(content: content)
//
//
//            }
//            reportAlert.addTextField { (mytext) in
//                mytext.tintColor = .nuteeGreen
//                mytext.placeholder = "신고할 내용을 입력해주세요."
//            }
//            reportAlert.addAction(cancelAction)
//            reportAlert.addAction(reportAction)
//
//            RootVC.present(reportAlert, animated: true, completion: nil)
//
//        }
//    }
}
