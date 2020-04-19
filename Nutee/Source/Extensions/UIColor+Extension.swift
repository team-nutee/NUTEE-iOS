//
//  UIColor+Extension.swift
//  Nutee
//
//  Created by Junhyeon on 2020/01/24.
//  Copyright © 2020 S.OWL. All rights reserved.
//

import UIKit

extension UIColor {
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }

    @nonobjc class var veryLightPink: UIColor {
      return UIColor(white: 209.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var nuteeGreen: UIColor {
        return UIColor(red: 19.0 / 255.0, green: 194.0 / 255.0, blue: 118.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var pantoneGreen2019: UIColor {
        return UIColor(red: 129.0 / 255.0, green: 228.0 / 255.0, blue: 189.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var pantoneGreen2020: UIColor {
        return UIColor(red: 0 / 255.0, green: 135.0 / 255.0, blue: 58.0 / 255.0 , alpha: 0.6)
    }
    
    @nonobjc class var nuteeGreen2: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }

    // MARK: - Green
    
    @nonobjc class var greenLighter: UIColor {
        return UIColor(red: 227 / 255.0, green: 241 / 255.0, blue: 223 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var greenLight: UIColor {
        return UIColor(red: 187 / 255.0, green: 229 / 255.0, blue: 179 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var green: UIColor {
        return UIColor(red: 80 / 255.0, green: 184 / 255.0, blue: 60 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var greenDark: UIColor {
        return UIColor(red: 16 / 255.0, green: 128 / 255.0, blue: 67 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var greenDarker: UIColor {
        return UIColor(red: 23 / 255.0, green: 54 / 255.0, blue: 48 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var greenText: UIColor {
        return UIColor(red: 65 / 255.0, green: 79 / 255.0, blue: 62 / 255.0 , alpha: 1.0)
    }

    
    // MARK: - Red
    
    @nonobjc class var redLighter: UIColor {
        return UIColor(red: 251 / 255.0, green: 234 / 255.0, blue: 229 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var redLight: UIColor {
        return UIColor(red: 254 / 255.0, green: 173 / 255.0, blue: 154 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var red: UIColor {
        return UIColor(red: 222 / 255.0, green: 54 / 255.0, blue: 24 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var redDark: UIColor {
        return UIColor(red: 191 / 255.0, green: 7 / 255.0, blue: 17 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var redDarker: UIColor {
        return UIColor(red: 51 / 255.0, green: 1 / 255.0, blue: 1 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var redText: UIColor {
        return UIColor(red: 88 / 255.0, green: 60 / 255.0, blue: 53 / 255.0 , alpha: 1.0)
    }

    
    // MARK: - Blue
    
    @nonobjc class var blueLighter: UIColor {
        return UIColor(red: 235 / 255.0, green: 245.0 / 255.0, blue: 250.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var blueLight: UIColor {
        return UIColor(red: 180 / 255.0, green: 225.0 / 255.0, blue: 250.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var blue: UIColor {
        return UIColor(red: 0 / 255.0, green: 111.0 / 255.0, blue: 187.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var blueDark: UIColor {
        return UIColor(red: 8 / 255.0, green: 78.0 / 255.0, blue: 138.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var blueDarker: UIColor {
        return UIColor(red: 0 / 255.0, green: 20.0 / 255.0, blue: 138.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var blueText: UIColor {
        return UIColor(red: 0 / 255.0, green: 20.0 / 255.0, blue: 41.0 / 255.0 , alpha: 1.0)
    }


    // MARK: - Orange
    
    @nonobjc class var orangeLighter: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var orangeLight: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var orange: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var orangeDark: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var orangeDarker: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var orangeText: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }


    // MARK: - Teal
    
    @nonobjc class var tealLighter: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var tealLight: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var teal: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var tealDark: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var tealDarker: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var tealText: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }


    // MARK: - Purple
    
    @nonobjc class var purpleLighter: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var purpleLight: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var purple: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var purpleDark: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var purpleDarker: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var purpleText: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }


    // MARK: - Indigo
    
    @nonobjc class var indigoLighter: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var indigoLight: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var indigo: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var indigoDark: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var indigoDarker: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var indigoText: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }


    // MARK: - Sky

    @nonobjc class var skyLighter: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var skyLight: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var sky: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var skyDark: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var skyDarker: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var skyText: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }


    // MARK: - Lik
    
    @nonobjc class var inkLightest: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var inkLighter: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var inkLight: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var ink: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    


    // MARK: - Title Bar
        
    @nonobjc class var titleBarLight: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var titleBar: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var titleBarDark: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var titleBarDarker: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    

    // MARK: - Yellow
    
    @nonobjc class var yellowLighter: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var yellowLight: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var yellow: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var yellowDark: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var yellowDarker: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var yellowText: UIColor {
        return UIColor(red: 239 / 255.0, green: 251.0 / 255.0, blue: 245.0 / 255.0 , alpha: 1.0)
    }

    // MARK: - Comment Window
    @nonobjc class var commentWindowLight: UIColor {
        return UIColor(red: 230 / 255.0, green: 234.0 / 255.0, blue: 240.0 / 255.0 , alpha: 1.0)
    }
    
    @nonobjc class var commentWindowDark: UIColor {
        return UIColor(red: 20 / 255.0, green: 22.0 / 255.0, blue: 23.0 / 255.0 , alpha: 1.0)
    }
    
}
