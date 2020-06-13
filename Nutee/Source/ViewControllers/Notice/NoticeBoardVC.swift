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
import FirebaseAnalytics

class NoticeBoardVC: TabmanViewController {
    
    // MARK: - UI components
    let bar = TMBar.ButtonBar()

    
    // MARK: - Variables and Properties
    private var viewControllers = [BachelorVC(), ClassVC(), ExchangeVC(), ScholarshipVC(), GeneralVC(), EventVC()]
    
    var content : [[String]] = Array(repeating: Array(repeating: "", count: 0), count: 0)
    var link : [[String]] = Array(repeating: Array(repeating: "", count: 0), count: 0)
    let title1 : [String] = ["학사공지","수업공지","학점교류","장학공지","일반공지","행사공지"]

    // MARK: - dummy data
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        bar.layout.transitionStyle = .snap
        
        addBar(bar, dataSource: self, at: .top)
        setting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        Analytics.logEvent("noticeview", parameters: [
           "name": "공지사항 뷰 선택" as NSObject,
           "full_text": "공지사항 뷰 선택" as NSObject
           ])
        
        // 네비바 border 삭제
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
    func setting(){
        let view = UIView()
        view.backgroundColor = .white
        bar.backgroundView.style = .custom(view: view)
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 10, bottom: 0.0, right: 10.0)
        bar.layout.contentMode = .intrinsic
        bar.indicator.tintColor = .nuteeGreen
        bar.buttons.customize { (button) in
            button.borderColor = .orange
            button.selectedTintColor = .nuteeGreen
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

