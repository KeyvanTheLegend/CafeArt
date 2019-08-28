//
//  Extentetions.swift
//  CafeArt
//
//  Created by Keyvan Yaghoubian on 7/29/19.
//  Copyright © 2019 Keyvan Yaghoubian. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController  {
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
        
    }
    func showToast(message: String, secends: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.alpha = 0.6
        alert.view.backgroundColor = UIColor.black
        alert.view.layer.cornerRadius = 15
        self.present(alert,animated:true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+secends) {
            alert.dismiss(animated: true)
        }
    }
    func getViewController (id : String) -> UIViewController{
        
            let storybord = UIStoryboard (name: "Main", bundle: nil)
            let target = storybord.instantiateViewController(withIdentifier:    "\(id)")

        
        return target

    }
    func base64Convert(base64String: String?) -> UIImage{
        if (base64String?.isEmpty)! {
            return #imageLiteral(resourceName: "no_image_found")
        }else {
            // !!! Separation part is optional, depends on your Base64String !!!
            let temp = base64String?.components(separatedBy: ",")
            let dataDecoded : Data = Data(base64Encoded: temp![1], options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: dataDecoded)
            return decodedimage!
        }
    }
}
extension UIView  {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable  open var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
extension UITextField {
    @IBInspectable  open var editingColor: UIColor? {
        get {
            if(self.isEditing){
                print("HI")
                layer.borderColor = self.editingColor?.cgColor
            }
            else{
                print("HI2")
                
                layer.borderColor = self.editingColor?.cgColor
            }
            return UIColor(cgColor: layer.borderColor!)
        }
        
        set {
            if(self.isEditing){
                print("HI")
            layer.borderColor = editingColor?.cgColor
            }
            else{
                print("HI2")

            layer.borderColor = borderColor?.cgColor

            }
        }
    }

}
/*
extension ShadowedView  {
    
    @IBInspectable var hasSHadow: Bool {
        get {
            return true
        }
        set {
            if(newValue){
                self.shadowLayer.elevation = .cardPickedUp
            }
            
        }
    }
}*/
    
