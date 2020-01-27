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
        
        self.chatTV.delegate = self
        self.chatTV.dataSource = self
        chatTV.register(UINib(nibName: "MyChatTVC", bundle: nil), forCellReuseIdentifier: "MyChatTVC")
    }
    
    // MARK: -Helpers

    // 초기 설정
    func setInit() {
        
    }
    
    func setDefault() {

    }
    


}

extension ChattingVC : UITableViewDelegate { }

extension ChattingVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MyChatTVC", for: indexPath) as! MyChatTVC
        
        return cell

    }
    
    
}
