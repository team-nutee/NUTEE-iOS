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
    
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        noticeTV.delegate = self
        noticeTV.dataSource = self
    }
    
}

extension NoticeBoardVC : UITableViewDelegate { }

extension NoticeBoardVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
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
        NSLog("선택된 행은 \(indexPath.row) 번째 행입니다.")
    }
    
}
