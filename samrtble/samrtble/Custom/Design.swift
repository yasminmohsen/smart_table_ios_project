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
    case customorange  //rgb 255 227 172
    case customBej
    case customGrayBorderColor
    
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
        case .customBej :
            return [#colorLiteral(red: 1, green: 0.8901960784, blue: 0.6745098039, alpha: 1)]
        case.customGrayBorderColor :
            return [UIColor(red: 112/250, green: 112/250, blue: 112/250 ,alpha: 1.0)]
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


// for borders :- 

extension CALayer {

    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {

        let border = CALayer()

        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.height, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: self.frame.width , height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
            break
            
        default:
            break
        }

        border.backgroundColor = color.cgColor;

        self.addSublayer(border)
    }

}




extension UISegmentedControl {
func setSegmentStyle() {
    setBackgroundImage(imageWithColor(color: UIColor.white), for: .normal, barMetrics: .default)
    setBackgroundImage(imageWithColor(color:  UIColor(red: 52/255, green: 192/255, blue: 196/255, alpha: 1.0)), for: .selected, barMetrics: .default)
    setDividerImage(imageWithColor(color: UIColor.clear), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)



     let segAttributes: NSDictionary = [
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ]

    setTitleTextAttributes(segAttributes as! [NSAttributedString.Key : Any] , for: UIControl.State.selected)
    
    let segAttributes_normal: NSDictionary = [
       NSAttributedString.Key.foregroundColor: UIColor.black,
       NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)
       ]
    
    setTitleTextAttributes(segAttributes_normal as! [NSAttributedString.Key : Any] , for: UIControl.State.normal)
    }

    // create a 1x1 image with this color
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width:  1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor);
        context!.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!
    }
}
