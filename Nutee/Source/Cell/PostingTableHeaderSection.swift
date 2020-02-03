//
//  PostingTableHeaderSection.swift
//  Nutee
//
//  Created by Hee Jae Kim on 2020/02/02.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class PostingTableHeaderSection: UITableViewHeaderFooterView {
    
    @IBOutlet var txtvwPosting: UITextView!
    @IBOutlet var btnImageUpload: UIButton!
    @IBOutlet var btnPosting: UIButton!
    
}

extension PostingTableHeaderSection : UITextFieldDelegate {
 
    //when editing start
    func textViewDidBeginEditing(_ textView: UITextView) {
        
    }
    
    /*
    func textViewPlaceHolder() {
        if txtvwPosting.text == "오늘 힘들 일이 있었나요?" {
            txtvwPosting = ""
            txtvwPosting.textColor = UIColor.black
        } if txtvwPosting.text = 
    }
    */
}
