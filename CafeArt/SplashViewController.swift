//
//  SplashViewController.swift
//  CafeArt
//
//  Created by Keyvan Yaghoubian on 8/7/19.
//  Copyright © 2019 Keyvan Yaghoubian. All rights reserved.
//

import UIKit
import Hero
class SplashViewController: UIViewController {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var bird: UIImageView!
    @IBOutlet weak var cloud: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        icon.hero.id = "icon"
        // Do any additional setup after loading the view.
        bird.animationImages = [UIImage]()
        
        for i in 1...2 {
            let frameName = String(format: "%03d", i) // Frame%03d means AssetName/AmountOfZeros/Increment
            bird.animationImages!.append(UIImage(named: frameName)!)
        }
        bird.animationDuration = 0.6 // Seconds
        bird.startAnimating()
        UIView.animate(withDuration: 3.1, delay: 0, options: [.curveEaseOut], animations: {
            
            self.cloud.transform = CGAffineTransform(translationX: -350, y: 0)
        }, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.9, execute: {
            let storybord = UIStoryboard (name: "Main", bundle: nil)
            let sharedPref = UserDefaults.standard

            if(sharedPref.object(forKey: "Token") != nil){
                 let root = storybord.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                self.present(root, animated: true, completion: nil)

            }
            else{
            let root = storybord.instantiateViewController(withIdentifier: "PhoneNumberViewController") as! PhoneNumberViewController
            self.present(root, animated: true, completion: nil)
        }
        })
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
