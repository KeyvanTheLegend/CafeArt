//
//  ActivationViewController.swift
//  CafeArt
//
//  Created by Keyvan Yaghoubian on 7/29/19.
//  Copyright © 2019 Keyvan Yaghoubian. All rights reserved.
//

import UIKit

class ActivationViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var numberLable: UILabel!
    var LorR = "R"
    @IBOutlet weak var icon: UIImageView!
    let DarkColor : UIColor = UIColor(red:0.32, green:0.20, blue:0.16, alpha:1.0)
    let LightColor : UIColor = UIColor(red:0.57, green:0.37, blue:0.30, alpha:1.0)
    var countdowntime = 60
    @IBOutlet weak var underline1height: NSLayoutConstraint!
    @IBOutlet weak var underline2height: NSLayoutConstraint!
    @IBOutlet weak var underline3height: NSLayoutConstraint!
    @IBOutlet weak var underline4height: NSLayoutConstraint!
    @IBOutlet weak var underline4: UIView!
    @IBOutlet weak var underline3: UIView!
    @IBOutlet weak var underline2: UIView!
    @IBOutlet weak var underline1: UIView!
    @IBOutlet weak var lable1: UILabel!
    @IBOutlet weak var lable2: UILabel!
    @IBOutlet weak var lable3: UILabel!
    @IBOutlet weak var lable4: UILabel!
    @IBOutlet weak var textfield1: UITextField!
    @IBOutlet weak var textfield2: UITextField!
    @IBOutlet weak var textfield3: UITextField!
    @IBOutlet weak var textfield4: UITextField!
    @IBAction func editing(_ sender: UITextField) {
        switch sender.tag {
        case 0:
            //lable1.text = "\(sender.text!.substring(from: sender.text!.endIndex))"
            
            if(sender.text!.count<=1){
                lable1.text = ""
                sender.text = " "
            }
            if(sender.text!.count>1){
                lable1.text = "\(sender.text!.split(separator: " ")[0])"
                sender.endEditing(true)
                textfield2.becomeFirstResponder()
                textfield2.text = " "
            }
            
        case 1:
            print(sender.text!)
            if(sender.text!.count==0){
                lable1.text = ""
                sender.endEditing(true)
                textfield1.becomeFirstResponder()
                textfield1.text = " "

            }
            if(sender.text!.count==1){
                lable2.text = ""
            }
            else if(sender.text!.count>1){
                print("HI2232")
                lable2.text = "\(sender.text!.split(separator: " ")[0])"
                sender.endEditing(true)
                textfield3.becomeFirstResponder()
                textfield3.text = " "
            }
        case  2:
            if(sender.text!.count==0){
                lable2.text = ""
                textfield2.text = " "
                textfield2.becomeFirstResponder()
                sender.endEditing(true)

            }
            if(sender.text!.count==1){
                lable3.text = ""
            }
            if(sender.text!.count>1){
                sender.endEditing(true)
                lable3.text = "\(sender.text!.split(separator: " ")[0])"
                textfield4.text = " "
                lable4.text = ""
                textfield4.becomeFirstResponder()
            }
        case 3:
            if(sender.text!.count==0){
                lable3.text = ""
                textfield3.text = " "
                textfield3.becomeFirstResponder()
                sender.endEditing(true)

            }
            
            if(sender.text!.count==1){
                lable4.text = ""
            }
            if(sender.text!.count>1){
                lable4.text = "\(sender.text!.split(separator: " ")[0])"
            }
        default:
            print("HI")
        }
    }
    @IBAction func startEditing(_ sender: UITextField, forEvent event: UIEvent) {
        print(sender.tag)
        switch sender.tag {
        case 0:
            print("HO")
            lable1.textColor = DarkColor
            underline1.backgroundColor = DarkColor
            underline1height.constant += 0.2
            lable1.font = UIFont(name: "IRANYekan-Bold", size: 16)
            self.view.layoutIfNeeded()
        case 1:
            lable2.textColor = DarkColor
            underline2.backgroundColor = DarkColor
            underline2height.constant += 0.2
            lable2.font = UIFont(name: "IRANYekan-Bold", size: 16)
            self.view.layoutIfNeeded()
        
        case 2:
            lable3.textColor = DarkColor
            underline3.backgroundColor = DarkColor
            underline3height.constant += 0.2
            lable3.font = UIFont(name: "IRANYekan-Bold", size: 16)
            self.view.layoutIfNeeded()
        case 3:
            lable4.textColor = DarkColor
            underline4.backgroundColor = DarkColor
            underline4height.constant += 0.2
            lable4.font = UIFont(name: "IRANYekan-Bold", size: 16)
            self.view.layoutIfNeeded()

        default:
            print("Hi")
        }
    }
    @IBAction func EndEditing(_ sender: UITextField, forEvent event: UIEvent) {
        print("\(sender.tag)   2")
        switch sender.tag {
        case 0:
            lable1.font = UIFont(name: "IRANYekan", size: 16)
            lable1.textColor = LightColor
            underline1height.constant -= 0.2
            underline1.backgroundColor = LightColor

        case 1:
            lable2.font = UIFont(name: "IRANYekan", size: 16)
            lable2.textColor = LightColor
            underline2height.constant -= 0.2
            underline2.backgroundColor = LightColor
        case 2:
            lable3.font = UIFont(name: "IRANYekan", size: 16)
            lable3.textColor = LightColor
            underline3height.constant -= 0.2
            underline3.backgroundColor = LightColor
        case 3:
            lable4.font = UIFont(name: "IRANYekan", size: 16)
            lable4.textColor = LightColor
            underline4height.constant -= 0.2
            underline4.backgroundColor = LightColor
        default:
            print("Hi")
        }

    }
    @IBOutlet weak var countdownlable: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        textfield1.delegate = self
        textfield2.delegate = self
        textfield3.delegate = self
        textfield4.delegate = self
        icon.hero.id = "icon"
        print(LorR)
        numberLable.text = "کد احراز هویت برای شماره \(phoneNumber) ارسال شد"
        startcountdown()
        // Do any additional setup after loading the view.
    }
    @IBAction func backd(_ sender: Any) {
        dismiss(animated: true)
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 2
    }
    
    @IBAction func taidBtn(_ sender: Any) {
        if(lable1.text != "" && lable2.text != "" && lable3.text! != "" && lable4.text != ""){
            let code = "\(lable1.text!)\(lable2.text!)\(lable3.text!)\(lable4.text!)"
            ServerCommands.init().Login_Veri(MobileNumber: phoneNumber, code: code, completion: { json in
                print(json)
                if(json["State"] as! Int == 1){
                DispatchQueue.main.async {
                    if(self.LorR == "L"){
                    let storybord = UIStoryboard (name: "Main", bundle: nil)
                    let target = storybord.instantiateViewController(withIdentifier:    "SignUpViewController") as! SignUpViewController
                        target.phoneNumber = self.phoneNumber
                    self.present(target, animated: true, completion: nil)
                    }
                    else{
                        DispatchQueue.main.async {
                            
                        
                        let storybord = UIStoryboard (name: "Main", bundle: nil)
                        let target = storybord.instantiateViewController(withIdentifier:    "ViewController") as! ViewController
                        self.present(target, animated: true, completion: nil)
                        }}
                }
                }
                else{
                    DispatchQueue.main.async {

                    self.showToast(message:"کد وارد شده نادرست است" , secends : 2)
                    }
                }
            }, unauthorized: { S in
                
            }) { e in
                
            }
            
            
        }
    }
    @IBOutlet weak var resendview: UIButton!
    @IBOutlet weak var resendlable: UILabel!
    var phoneNumber = ""
    @IBAction func resend_code(_ sender: Any) {
        countdowntime = 60
        countdownlable.isHidden = false
        ServerCommands.init().SendActivationCode2(MobileNumber: phoneNumber, completion: { json in
            print(json)
            if(!(json["Description"] is NSNull)){
                let LorR = json["Description"] as! String
                DispatchQueue.main.async {
                    
                    let storybord = UIStoryboard (name: "Main", bundle: nil)
                    let target = storybord.instantiateViewController(withIdentifier:    "ActivationViewController") as! ActivationViewController
                    target.LorR = LorR
                    self.present(target, animated: true, completion: nil)
                }
            }
            
        }, unauthorized: { s in
            
        }) { e in
            
        }
    }
    func startcountdown () {
        self.resendview.isHidden = true
        self.resendlable.isHidden = true

        DispatchQueue.global(qos: .background).async {
            while (self.countdowntime > 0){
                self.countdowntime = self.countdowntime - 1
                DispatchQueue.main.async {
                    let min  = self.countdowntime/60
                    let sec = self.countdowntime%60
                    self.countdownlable.text =  "\(min):\(String(format: "%02d" , sec))"

                }
                sleep(1)
            }
            
            if(self.countdowntime == 0){
                DispatchQueue.main.async {
                    self.countdownlable.text = "0:00"
                    self.resendview.isHidden = false
                    self.resendlable.isHidden = false

                }
            }
        }
        
    }
}
/*
 for family in UIFont.familyNames.sorted() {
 let names = UIFont.fontNames(forFamilyName: family)
 print("Family: \(family) Font names: \(names)")
 }*/
