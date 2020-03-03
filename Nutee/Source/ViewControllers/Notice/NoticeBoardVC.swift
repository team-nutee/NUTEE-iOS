//
//  NoticeBoardVC.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/01/14.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit
import Tabman
import Pageboy

class NoticeBoardVC: TabmanViewController {
    
    // MARK: - UI components
    @IBOutlet weak var noticeTV: UITableView!
    
    
    // MARK: - Variables and Properties
    private var viewControllers = [UIViewController(), UIViewController(), UIViewController(), UIViewController(), UIViewController(), UIViewController()]
    
    var content : [[String]] = Array(repeating: Array(repeating: "", count: 0), count: 0)
    var link : [[String]] = Array(repeating: Array(repeating: "", count: 0), count: 0)
    var content1 : [String] = []
    var link1 : [String] = []
    let title1 : [String] = ["일반","2번","3번","4번","5번","6번"]

    // MARK: - dummy data
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNotice()

        self.dataSource = self
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        addBar(bar, dataSource: self, at: .top)

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
        return content1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoticeBoardTVC", for: indexPath) as! NoticeBoardTVC
        
        cell.noticeTitleLabel?.text = content1[indexPath.row]
        cell.noticeTitleLabel.sizeToFit()
        cell.noticeDateLabel.text = ""
        //        cell.noticeTitleLabel?.text = date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = tableView.dequeueReusableCell(withIdentifier: "NoticeBoardTVC", for: indexPath) as! NoticeBoardTVC
        
        if let url = URL(string: link1[indexPath.row]) {
            UIApplication.shared.open(url)
        }

        
    }
    
}

extension NoticeBoardVC : PageboyViewControllerDataSource, TMBarDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let title2 = title1[index]
        return TMBarItem(title: title2)
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
                self.content1 = self.content[0]
                self.link1 = self.link[0]
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
