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
    
    
    // MARK: - dummy data
    
    var urlLink : [String] = ["http://www.hackingwithswift.com","https://www.naver.com","https://www.daum.net","https://www.kakao.com","https://www.musinsa.com"]
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noticeTV.delegate = self
        noticeTV.dataSource = self
        noticeTV.separatorInset.left = 0
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
        return urlLink.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let row = self.noticeList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoticeBoardTVC", for: indexPath) as! NoticeBoardTVC
        /*let title = cell.viewWithTag(101) as? UILabel
         let wirteDate = cell.viewWithTag(102) as? UILabel
         
         title?.text = row.title
         //writeDate?.text = row.description
         */
        
        //        cell.noticeDateLabel?.text = title
        //        cell.noticeTitleLabel?.text = date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoticeBoardTVC", for: indexPath) as! NoticeBoardTVC
        
        if let url = URL(string: urlLink[indexPath.row]) {
            UIApplication.shared.open(url)
        }

        
    }
    
}
