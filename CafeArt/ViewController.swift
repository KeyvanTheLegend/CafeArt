//
//  ViewController.swift
//  CafeArt
//
//  Created by Apple on 5/16/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var title1: UIImageView!
    @IBOutlet weak var location: UIButton!
    @IBOutlet weak var gallary: UIButton!
    @IBOutlet weak var event: UIButton!
    @IBOutlet weak var profile: UIButton!
    @IBOutlet weak var menu: UIButton!
    var x = false
    @IBOutlet weak var imgviewholder: UIImageView!
    @IBAction func profile(_ sender: Any) {
        let sharedPref = UserDefaults.standard

        let token = sharedPref.object(forKey: "UserType") as! String
        if(token == "activated"){
        let target = getViewController(id: "ProfileViewController") as! ProfileViewController
            self.present(target, animated: true)
        }
        else{
            let target = getViewController(id: "SignUpViewControllerPoPup") as! SignUpViewControllerPoPup
            self.present(target, animated: true) {
                
            }
        }
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imgviewholder.layer.borderWidth = 1
        imgviewholder.layer.borderColor = UIColor(red:0.63, green:0.53, blue:0.50, alpha:0.2).cgColor

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("2 \(gallary.bounds)")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //setting gradient
        if(!x){
            x = true
        let Colors = Coloros.init()
        gallary.setGradientBackground(colorOne: Colors.brownbutton, colorTwo: Colors.center,colorThree: Colors.brownbutton)
        profile.setGradientBackground(colorOne: Colors.brownbutton, colorTwo: Colors.center,colorThree: Colors.brownbutton)
        location.setGradientBackground(colorOne: Colors.brownbutton, colorTwo: Colors.center,colorThree: Colors.brownbutton)
        event.setGradientBackground(colorOne: Colors.brownbutton, colorTwo: Colors.center,colorThree: Colors.brownbutton)
        menu.setGradientBackground(colorOne: Colors.brownbutton, colorTwo: Colors.center,colorThree: Colors.brownbutton)
        title1.setGradientBackground(colorOne: Colors.title_start_color, colorTwo: Colors.title_end_color,colorThree: Colors.title_end_color)

        }
    }
}

//6274121175033422
//343

