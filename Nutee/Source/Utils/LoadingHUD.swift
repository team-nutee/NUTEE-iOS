//
//  Util.swift
//  Nutee
//
//  Created by Junhyeon on 2020/01/06.
//  Copyright © 2020 Junhyeon. All rights reserved.
//

import Foundation
import UIKit

class LoadingHUD: NSObject {
    
    private static let sharedInstance = LoadingHUD()
    
    private var backgroundView: UIView?
    private var popupView: UIImageView?
    private var loadingLabel: UILabel?
    class func hide() {
        if let popupView = sharedInstance.popupView,
        let backgroundView = sharedInstance.backgroundView {
            popupView.stopAnimating()
            backgroundView.removeFromSuperview()
            popupView.removeFromSuperview()
        }
    }

    class func show() {
        let backgroundView = UIView(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        
        let popupView = UIImageView()//= UIImageView(frame: CGRect.init(x: 0, y: 0, width: 200, height: 500))
        popupView.contentMode = .topRight
        popupView.animationImages = LoadingHUD.getAnimationImageArray()
        popupView.animationDuration = 3
        popupView.animationRepeatCount = 0
        
        
        if let window = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
        .filter({$0.isKeyWindow}).first {
            window.addSubview(backgroundView)
            window.addSubview(popupView)
            
            backgroundView.frame = CGRect(x: 0, y: 0, width: window.frame.maxX, height: window.frame.maxY)
            backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
            
            popupView.frame = CGRect(x: 0, y: 0,width: window.frame.maxX, height: window.frame.maxY)
            popupView.startAnimating()
                        
            sharedInstance.backgroundView?.removeFromSuperview()
            sharedInstance.popupView?.removeFromSuperview()
            sharedInstance.loadingLabel?.removeFromSuperview()
            sharedInstance.backgroundView = backgroundView
            sharedInstance.popupView = popupView
        }
    }

    public class func getAnimationImageArray() -> [UIImage] {
        var animationArray: [UIImage] = []
        animationArray.append(UIImage(named: "nuteeLoading_00")!)
        animationArray.append(UIImage(named: "nuteeLoading_01")!)
        animationArray.append(UIImage(named: "nuteeLoading_02")!)
        animationArray.append(UIImage(named: "nuteeLoading_03")!)
        animationArray.append(UIImage(named: "nuteeLoading_04")!)
        animationArray.append(UIImage(named: "nuteeLoading_05")!)
        animationArray.append(UIImage(named: "nuteeLoading_06")!)
        animationArray.append(UIImage(named: "nuteeLoading_07")!)
        animationArray.append(UIImage(named: "nuteeLoading_08")!)
        animationArray.append(UIImage(named: "nuteeLoading_09")!)
        animationArray.append(UIImage(named: "nuteeLoading_09")!)
        animationArray.append(UIImage(named: "nuteeLoading_09")!)
        animationArray.append(UIImage(named: "nuteeLoading_09")!)
        animationArray.append(UIImage(named: "nuteeLoading_08")!)
        animationArray.append(UIImage(named: "nuteeLoading_07")!)
        animationArray.append(UIImage(named: "nuteeLoading_06")!)
        animationArray.append(UIImage(named: "nuteeLoading_05")!)
        animationArray.append(UIImage(named: "nuteeLoading_04")!)
        animationArray.append(UIImage(named: "nuteeLoading_03")!)
        animationArray.append(UIImage(named: "nuteeLoading_02")!)
        animationArray.append(UIImage(named: "nuteeLoading_01")!)
        animationArray.append(UIImage(named: "nuteeLoading_00")!)

        return animationArray
    }
}
