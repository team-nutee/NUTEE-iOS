//
//  BachelorView.swift
//  Nutee
//
//  Created by Junhyeon on 2020/03/09.
//  Copyright © 2020 S.OWL. All rights reserved.
//

// 학사공지

import UIKit
import SnapKit

class BachelorVC: UIViewController {
    
    let bachelorTV: UITableView = UITableView()
    var notice : [String] = []
    var link : [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bachelorTV.dataSource = self
        self.bachelorTV.delegate = self
        
        self.bachelorTV.register(UITableViewCell.self, forCellReuseIdentifier: "BachelorTVC")
        
        self.view.addSubview(self.bachelorTV)
        
        self.bachelorTV.snp.makeConstraints({ (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.left.equalTo(0)
        })
        
        setNotice()
        
    }
    
        
}

extension BachelorVC : UITableViewDelegate { }

extension BachelorVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notice.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "BachelorTVC", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = notice[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = tableView.dequeueReusableCell(withIdentifier: "BachelorTVC", for: indexPath) as UITableViewCell
        
        if let url = URL(string: link[indexPath.row]) {
            UIApplication.shared.open(url)
        }


    }
    
    
}

extension BachelorVC {
    func setNotice(){
        NoticeService.shared.getNotice(){
            [weak self]
            data in
            
            guard let `self` = self else { return }
            
            switch data {
                
            // 매개변수에 어떤 값을 가져올 것인지
            case .success(let res):
                let response = res as! Notice
                
                self.notice = response.content[0]
                self.link = response.hrefs[0]
                
                self.bachelorTV.reloadData()

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


