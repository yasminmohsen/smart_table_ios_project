//
//  FirstScreenViewController.swift
//  samrtble
//
//  Created by Yasmin Mohsen on 26/03/2021.
//

import UIKit


class FirstScreenViewController: UIViewController {
    
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriotionLabel: UILabel!
    static let GO_LOGIN = "goLogin"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        titleLabel.textColor = Colors.getColor(type: .customGreen)[0]
        skipBtn.setTitle("Skip".localized, for: .normal)
        CustomDesignView.customPageController(pageControl)
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        leftSwipe.direction = .left
        self.view.addGestureRecognizer(leftSwipe)
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
        CheckUserDeafaults()
    }
    override func viewDidLayoutSubviews() {
        
    }
    
    func CheckUserDeafaults()  {
        let defaults = UserDefaults.standard
        if(defaults.string(forKey: MainLoginViewController.PHONE_KEY) != nil){
            var vc = self.storyboard?.instantiateViewController(withIdentifier: "TableHome")as! TableHomeViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
    @objc func swipe(gesture :UISwipeGestureRecognizer) {
        let lang = LanguageOperation.checkLanguage()
        let vc = storyboard?.instantiateViewController(identifier: "secondVc") as! SecondScreenViewController
        switch gesture.direction {
        case .right:
            switch lang {
            case .arabic:
                self.navigationController?.pushViewController(vc, animated: true)
                
            default:
                break
            }
            
        case .left:
            
            switch lang {
            case .english:
                
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                break
            }
        default:
            break
        }
    }
    
    @IBAction func skip(_ sender: Any) {
        let defults = UserDefaults.standard
        defults.setValue("goLogin", forKey: FirstScreenViewController.GO_LOGIN)
    }
    
}



//extension UIImage {
//    func maskWithGradientColor(color: UIColor) -> UIImage? {
//
//        let maskImage = self.cgImage
//        let width = self.size.width
//        let height = self.size.height
//        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
//
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
//        let bitmapContext = CGContext(data: nil,
//                                      width: Int(width),
//                                      height: Int(height),
//                                      bitsPerComponent: 8,
//                                      bytesPerRow: 0,
//                                      space: colorSpace,
//                                      bitmapInfo: bitmapInfo.rawValue)
//
//        let locations:[CGFloat] = [0.0, 1.0]
//        let bottom = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
//        let top = UIColor(red: 0, green: 1, blue: 0, alpha: 0).cgColor
//        let colors = Colors.getColor(type: .gradientWhite)
//        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations)
//        let startPoint = CGPoint(x: width/2, y: 0)
//        let endPoint = CGPoint(x: width/2, y: height)
//
//        bitmapContext!.clip(to: bounds, mask: maskImage!)
//        bitmapContext!.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: UInt32(0)))
//
//        if let cImage = bitmapContext!.makeImage() {
//            let coloredImage = UIImage(cgImage: cImage)
//            return coloredImage
//        }
//        else  {
//            return nil
//        }
//    }
//}
