//
//  EditViewController.swift
//  CafeArt
//
//  Created by Keyvan Yaghoubian on 8/25/19.
//  Copyright © 2019 Keyvan Yaghoubian. All rights reserved.
//

import UIKit
import VisualEffectView

class EditViewController: UIViewController {
    @IBOutlet weak var editText1: UITextField!
    @IBOutlet weak var editText2: UITextField!
    
    @IBOutlet weak var lable1: UILabel!
    @IBOutlet weak var lable2: UILabel!
    @IBAction func startediting(_ sender: Any) {
        lable1.text = editText1.text
    }
    @IBAction func startediting2(_ sender: Any) {
        lable2.text = editText2.text

    }
    var namevar = ""
    var numbervar = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lable1.text = namevar
        lable2.text = numbervar
        blurView.blurRadius = 3
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var blurView: VisualEffectView!
    
    @IBAction func laghv(_ sender: Any) {
        dismiss(animated: true) {
            
        }
    }
    @IBAction func sabt(_ sender: Any) {
        ServerCommands.init().update(Name: editText1.text!, Birthdate: birthDay, completion: { json in
            DispatchQueue.main.async {
                self.   dismiss(animated: true)

            }
        }, unauthorized: { e in
            
        }) { e in
            
        }
    }
    
    @IBOutlet weak var britDayLable: UILabel!
    var birthDay = ""
    @IBAction func taghvim(_ sender: Any) {
        
        self.view.endEditing(true)
        let storybord = UIStoryboard (name: "Main", bundle: nil)
        let target = storybord.instantiateViewController(withIdentifier:    "DatePickerPopUp") as! DatePickerPopUp
        target.x = { z in
            self.birthDay = z
            self.britDayLable.text = z
        }
        self.present(target, animated: true, completion: nil)
        
        
    }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


