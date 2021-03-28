//
//  Design.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 26/03/2021.
//

import Foundation
import UIKit


enum CustomFonts : String{
case MyriadProBold = "Myriad Pro Bold"
case MyriadPro = "Myriad Pro"
   
}




extension UIView {
    @discardableResult
    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colours: colours, locations: nil)
    }

    @discardableResult
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.frame.size = self.frame.size
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
       gradient.startPoint = CGPoint(x: 0, y: 0)
       gradient.endPoint = CGPoint(x: 1, y: 0)
        //gradient.masksToBounds = true
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
    
    
    // (like on `UIImageView`)
       func asImage() -> UIImage {
           let renderer = UIGraphicsImageRenderer(bounds: bounds)
           return renderer.image { rendererContext in
               layer.render(in: rendererContext.cgContext)
           }
       }
}





enum ColorsName {
    
    case gradientWhite
    case gradientGreen
    case customGreen
    case customorange
    
    
}


class Colors{
    
    static func getColor(type : ColorsName)->[UIColor]{
       
        switch type {
        case .gradientWhite:
            return [#colorLiteral(red: 0.9764705882, green: 0.9843137255, blue: 0.9882352941, alpha: 1), #colorLiteral(red: 0.9411764706, green: 0.9568627451, blue: 0.9882352941, alpha: 1),#colorLiteral(red: 0.8470588235, green: 0.8901960784, blue: 0.9960784314, alpha: 1), #colorLiteral(red: 0.8039215686, green: 0.8588235294, blue: 1, alpha: 1)]
        case .gradientGreen:
            return [#colorLiteral(red: 0.1490196078, green: 0.6039215686, blue: 0.6431372549, alpha: 1), #colorLiteral(red: 0.2039215686, green: 0.7529411765, blue: 0.768627451, alpha: 1)]
        case .customGreen :
            return [UIColor(red: 0/255, green: 149/255, blue: 154/255, alpha: 1.0)]
        case .customorange :
            return [#colorLiteral(red: 0.9215686275, green: 0.6705882353, blue: 0.1764705882, alpha: 1)]
            
        default:
            break
        }
        
     
        
    }
}




@IBDesignable
public class GradientButton: UIButton {
    public override class var layerClass: AnyClass         { CAGradientLayer.self }
    private var gradientLayer: CAGradientLayer             { layer as! CAGradientLayer }

    @IBInspectable public var startColor = #colorLiteral(red: 0.1490196078, green: 0.6039215686, blue: 0.6431372549, alpha: 1) { didSet { updateColors() } }
    @IBInspectable public var endColor = #colorLiteral(red: 0.2039215686, green: 0.7529411765, blue: 0.768627451, alpha: 1)   { didSet { updateColors() } }

    // expose startPoint and endPoint to IB

    @IBInspectable public var startPoint: CGPoint {
        get { gradientLayer.startPoint }
        set { gradientLayer.startPoint = newValue }
    }

    @IBInspectable public var endPoint: CGPoint {
        get { gradientLayer.endPoint }
        set { gradientLayer.endPoint = newValue }
    }

    // while we're at it, let's expose a few more layer properties so we can easily adjust them in IB

    @IBInspectable public var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }

    @IBInspectable public var borderWidth: CGFloat {
        get { layer.borderWidth }
        set { layer.borderWidth = newValue }
    }

    @IBInspectable public var borderColor: UIColor? {
        get { layer.borderColor.flatMap { UIColor(cgColor: $0) } }
        set { layer.borderColor = newValue?.cgColor }
    }

    // init methods

    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        updateColors()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        updateColors()
    }
}

private extension GradientButton {
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
}
