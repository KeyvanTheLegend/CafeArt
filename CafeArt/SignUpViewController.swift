//
//  SignUpViewController.swift
//  CafeArt
//
//  Created by Keyvan Yaghoubian on 8/9/19.
//  Copyright © 2019 Keyvan Yaghoubian. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    let myColors = Coloros.init()
    var gender = 1
    var phoneNumber = ""
    var britDay = ""
    @IBOutlet weak var namesF: UITextField!
    @IBAction func datePicker(_ sender: Any) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let storybord = UIStoryboard (name: "Main", bundle: nil)
            let target = storybord.instantiateViewController(withIdentifier:    "DatePickerPopUp") as! DatePickerPopUp
            target.x = { z in
                self.britDay = z
                self.dateField.text = z
            }
            self.present(target, animated: true, completion: nil)

            
        }
    }
    @IBOutlet weak var heightC: NSLayoutConstraint!
    @IBOutlet weak var khanumlable: UILabel!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var aghalable: UILabel!
    let colors = Coloros.init()

    @IBAction func sabtename(_ sender: Any) {
        if(namesF.text != "" && britDay != ""){
        ServerCommands.init().Sign_up(MobileNumber: phoneNumber, name: namesF.text!, BirthDate: britDay, Gender: gender, completion: { json in
print(json)
        }, unauthorized: { e in
            
        }) { e in
            
        }
        }
    }
    @IBAction func khanumbtn(_ sender: Any) {
        khanumlable.backgroundColor = colors.DarkColor
        aghalable.backgroundColor = UIColor.clear
        khanumlable.textColor = colors.Yellow
        aghalable.textColor = colors.LightColor
        gender = 2

    }
    @IBAction func aghabtn(_ sender: Any) {
        gender = 1
        aghalable.backgroundColor = colors.DarkColor
        khanumlable.backgroundColor = UIColor.clear
        aghalable.textColor = colors.Yellow
        khanumlable.textColor = colors.LightColor


    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
