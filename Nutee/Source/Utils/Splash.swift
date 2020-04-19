//
//  Splash.swift
//  Nutee
//
//  Created by Junhyeon on 2020/03/18.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

class Splash: NSObject {
    
    private static let sharedInstance = Splash()
    
    private var backgroundView: UIView?
    private var popUpLabel: UILabel?
    
    
    class func hide() {
        if let popUpLabel = sharedInstance.popUpLabel,
        let backgroundView = sharedInstance.backgroundView {
            
            backgroundView.removeFromSuperview()
            popUpLabel.removeFromSuperview()
        }
    }

    class func show() {
        let backgroundView = UIView()
        
        let popUpLabel = UILabel()//= UIImageView(frame: CGRect.init(x: 0, y: 0, width: 200, height: 500))
        popUpLabel.text = "NUTEE"
        popUpLabel.textColor = .nuteeGreen
        popUpLabel.font = .systemFont(ofSize: 40, weight: .bold)
        popUpLabel.contentMode = .center
        popUpLabel.textAlignment = .center
        
        
        if let window = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
        .filter({$0.isKeyWindow}).first {
            window.addSubview(backgroundView)
            window.addSubview(popUpLabel)
            
            backgroundView.frame = CGRect(x: 0, y: 0, width: window.frame.maxX, height: window.frame.maxY)
            backgroundView.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
            
            popUpLabel.frame = CGRect(x: 0, y: 0,width: window.frame.maxX, height: window.frame.maxY - 350)
                        
            sharedInstance.backgroundView?.removeFromSuperview()
            sharedInstance.popUpLabel?.removeFromSuperview()
            sharedInstance.backgroundView = backgroundView
            sharedInstance.popUpLabel = popUpLabel
        }
    }


}

