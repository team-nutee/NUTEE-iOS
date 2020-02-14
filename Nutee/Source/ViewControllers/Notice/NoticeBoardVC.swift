//
//  NoticeBoardVC.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/01/14.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class NoticeBoardVC: UIViewController {
    
    // MARK: - UI components
    @IBOutlet weak var noticeTV: UITableView!
    
    
    // MARK: - Variables and Properties
   
    var content : [String] = []
    var link : [String] = []
    
    // MARK: - dummy data
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNotice()

        noticeTV.delegate = self
        noticeTV.dataSource = self
        noticeTV.separatorInset.left = 0
        
        noticeTV.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // 네비바 border 삭제
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
}

extension NoticeBoardVC : UITableViewDelegate { }

extension NoticeBoardVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let row = self.noticeList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoticeBoardTVC", for: indexPath) as! NoticeBoardTVC
        /*let title = cell.viewWithTag(101) as? UILabel
         let wirteDate = cell.viewWithTag(102) as? UILabel
         
         title?.text = row.title
         //writeDate?.text = row.description
         */
        
        cell.noticeTitleLabel?.text = content[indexPath.row]
        cell.noticeTitleLabel.sizeToFit()
        cell.noticeDateLabel.text = ""
        //        cell.noticeTitleLabel?.text = date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoticeBoardTVC", for: indexPath) as! NoticeBoardTVC
        
        if let url = URL(string: link[indexPath.row]) {
            UIApplication.shared.open(url)
        }

        
    }
    
}

extension NoticeBoardVC {
    func setNotice(){
        NoticeService.shared.getNotice(){
            [weak self]
            data in
            
            guard let `self` = self else { return }
            
            switch data {
                
            // 매개변수에 어떤 값을 가져올 것인지
            case .success(let res):
                print("공지사항 조회 성공")
                
                let response = res as! Notice
                
                self.content = response.content
                self.link = response.hrefs
                print(self.content)
                print(self.link)
                self.noticeTV.reloadData()
                
            case .requestErr(let message):
                self.simpleAlert(title: "공지사항 조회 실패", message: "\(message)")
                
            case .pathErr:
                print(".pathErr")
                
            case .serverErr:
                print(".serverErr")
                
            case .networkFail:
                self.simpleAlert(title: "카테고리 조회 실패", message: "네트워크 상태를 확인해주세요.")
            }

        }
    }

}
