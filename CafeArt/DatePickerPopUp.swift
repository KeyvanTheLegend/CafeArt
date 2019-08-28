//
//  DatePickerPopUp.swift
//  CafeArt
//
//  Created by Keyvan Yaghoubian on 8/11/19.
//  Copyright © 2019 Keyvan Yaghoubian. All rights reserved.
//

import UIKit
import PersianDatePicker

class DatePickerPopUp: UIViewController {
    var x : ((_ data : String ) ->())?
    
    @IBAction func taeeid(_ sender: Any) {
        x?(datrPicker.getPersianDate()!)
        dismiss(animated: true)

    }
    @IBOutlet weak var datrPicker: PersianDatePickerView!
    @IBAction func disx(_ sender: Any) {
        print(datrPicker.getPersianDate())
        print(datrPicker.day)
        print(datrPicker.month)
        dismiss(animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("X")
    }
    

    /*
     // MARK: - NavDateFormatterr/ In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
