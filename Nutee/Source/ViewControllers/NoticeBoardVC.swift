//
//  NoticeBoardVC.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/01/14.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class NoticeBoardVC: UITableViewController {
    
    //공지사항 목록 서버(홈페이지 공지사항 크롤링)에서 가져오기
    // <--- 코드 구현구간
    var dataset = [
        ("2020학년도 1학기 수강신청 안내", "2020-01-13"), 
        ("2020학년도 1학기 교내/교외 장학금 신청 안내", "2019-12-16")
    ]
    
    //공지사항 목록 구성을 위한 목록 데이터 구성
    // <--- 코드 구현구간
    lazy var noticeList: [NoticeBoardVO] = {
        var dataNoticeList = [NoticeBoardVO]()
        
        for (title, writeDate) in self.dataset {
            let ntcOb = NoticeBoardVO()
            ntcOb.title = title
            ntcOb.writeDate = writeDate
            dataNoticeList.append(ntcOb)
        }
        return dataNoticeList
    }()
    
    override func viewDidload( ) {
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.noticeList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.noticeList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "noticeCell")!
        
        let title = cell.viewWithTag(101) as? UILabel
        let desc = cell.viewWithTag(102) as? UILabel
        
        title?.text = row.title
        writeDate?.text = row.description
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath.row) 번째 행입니다.")
    }
    
}
