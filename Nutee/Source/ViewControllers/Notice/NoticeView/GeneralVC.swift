//
//  GeneralView.swift
//  Nutee
//
//  Created by Junhyeon on 2020/03/09.
//  Copyright © 2020 S.OWL. All rights reserved.
//

// 일반공지

import UIKit

import SafariServices

class GeneralVC: UIViewController {
    
    
    let generalTV: UITableView = UITableView()
    var isNotice: [String] = []
    var notice: [String] = []
    var link: [String] = []
    var date: [String] = []
    var author: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.generalTV.dataSource = self
        self.generalTV.delegate = self
        
        self.generalTV.register(UITableViewCell.self, forCellReuseIdentifier: "NoticeTVC")
                
        generalTV.register(UINib(nibName: "NoticeTVC", bundle: nil), forCellReuseIdentifier: "NoticeTVC")

        self.view.addSubview(self.generalTV)
        
        self.generalTV.snp.makeConstraints({ (make) in
            make.width.equalToSuperview()
            make.top.equalToSuperview().inset(70)
            make.bottom.equalToSuperview()
            make.left.equalTo(0)
        })
        setNotice()
        
    }
    
}

extension GeneralVC : UITableViewDelegate { }

extension GeneralVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if notice.count == 0 {
            tableView.setEmptyView(title: "", message: "")
        } else {
            tableView.restore()
        }

        return notice.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoticeTVC", for: indexPath) as! NoticeTVC

        cell.titleLabel.text = notice[indexPath.row]
        cell.authorLabel.text = author[indexPath.row]
        cell.dateLabel.text = date[indexPath.row]
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .greenLighter
        cell.selectedBackgroundView = backgroundView

        if (isNotice[indexPath.row] == "공지") {
            cell.isNoticeView.isHidden = false
        } else {
            cell.isNoticeView.isHidden = true
        }

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoticeTVC", for: indexPath) as! NoticeTVC
        let backgroundView = UIView()
        backgroundView.backgroundColor = .greenLighter
        cell.selectedBackgroundView = backgroundView
        
        let url = URL(string: link[indexPath.row])
        let safariViewController = SFSafariViewController(url: url!)
        safariViewController.preferredControlTintColor = .nuteeGreen
        
        present(safariViewController, animated: true, completion: nil)
        
        generalTV.reloadData()
    }
    
}
extension GeneralVC {
    func setNotice(){
        NoticeService.shared.getGeneralNotice(){
            [weak self]
            data in
            
            guard let `self` = self else { return }
            
            switch data {
                
            // 매개변수에 어떤 값을 가져올 것인지
            case .success(let res):
                let response = res as! Notice
                for i in response {
                    self.notice.append(i.title)
                    self.link.append(i.href)
                    self.date.append(i.date)
                    self.isNotice.append(i.no)
                    self.author.append(i.author)
                }
                
                self.generalTV.reloadData()
                
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


