//
//  ChattingVC.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/01/14.
//  Copyright © 2020 Junhyeon. All rights reserved.
//

import UIKit

class ChattingVC: UIViewController {
    
    // MARK: - UI components
    @IBOutlet weak var chatTV: UITableView!
    
    
    // MARK: - Variables and Properties
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setInit()
        setTV()
    }
    
    // MARK: -Helpers
    
    // 초기 설정
    func setInit() {
        chatTV.register(UINib(nibName: "MyChatTVC", bundle: nil), forCellReuseIdentifier: "MyChatTVC")
        self.chatTV.separatorStyle = .none
        chatTV.rowHeight = UITableView.automaticDimension
        
    }
    
    func setTV() {
        self.chatTV.delegate = self
        self.chatTV.dataSource = self
    }
    
    func setDefault() {
        
    }
    
    
    
}

extension ChattingVC : UITableViewDelegate { }

extension ChattingVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyChatTVC", for: indexPath) as! MyChatTVC
        cell.selectionStyle = .none
        return cell
    }
    
    
}
