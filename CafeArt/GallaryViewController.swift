//
//  GallaryViewController.swift
//  CafeArt
//
//  Created by Keyvan Yaghoubian on 8/17/19.
//  Copyright © 2019 Keyvan Yaghoubian. All rights reserved.
//

import UIKit
import ImageSlideshow
import VisualEffectView
import Cosmos
class GallaryViewController: UIViewController {
    @IBAction func backp(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBOutlet weak var ui_scroll_view: UIScrollView!
    var isOpen = false
    
   
    @IBOutlet weak var indicatorLable: UILabel!
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    func x() -> () {
        print("HI")
        print(slider.currentPage)
        indicatorLable.text = "\(slider.currentPage+1) از \(size)"
    }
    var size = 0
    var imageSource : [ImageSource] = []

    @IBOutlet weak var testview: UIView!
    @IBOutlet weak var slider: ImageSlideshow!
    override func viewDidLoad() {
        super.viewDidLoad()
        ServerCommands.init().getGallary(completion: { json in
            let des = json["Description"] as! String
            print(des)
            var i = 0
            if let data = des.data(using: .utf8) {
                do {
                    let json3 = try JSONSerialization.jsonObject(with: data,    options:JSONSerialization.ReadingOptions.mutableContainers) as!    NSArray
                    
                    for image in json3{
                        DispatchQueue.main.async {
                            i = i + 1
                            let image = image as! String
                            ServerCommands.init().GetImage(Link: image, completion: { x in
                                DispatchQueue.main.async {
                                    
                                    let img2 = self.base64Convert(base64String: x as! String)
                                    
                                    self.imageSource.append(ImageSource(image: img2))
                                    self.slider.setImageInputs(self.imageSource)
                                    self.slider.reloadInputViews()
                                    
                                }
                               
                            }, unauthorized: { e in
                                
                            }, onError:{ e in 
                            
                            })
                            
                            
                        
                    }
                }
                }catch{
                    
                }
            }
        }, unauthorized: { e in
            
        }) { e in
            
        }
        let pageIndicator = UIPageControl()
        let Colors = Coloros.init()
        pageIndicator.currentPageIndicatorTintColor = Colors.DarkColor
        pageIndicator.pageIndicatorTintColor = Colors.tintColor
        
        ui_scroll_view.keyboardDismissMode = .onDrag
        slider.pageIndicator = pageIndicator
        slider.didEndDecelerating = x
        slider.setImageInputs([
            ImageSource(image: UIImage(named: "IMG_0703")!),ImageSource(image: UIImage(named: "Group-197")!),ImageSource(image: UIImage(named: "Group-197")!),ImageSource(image: UIImage(named: "Group-197")!),ImageSource(image: UIImage(named: "Group-197")!),
            ImageSource(image: UIImage(named: "Group-198")!)
            ])
        
        size = slider.images.count
        indicatorLable.text = "\(slider.currentPage+1) از \(size)"
        
        slider.pageIndicator = nil
        slider.contentScaleMode = .scaleAspectFill
        slider.bringSubviewToFront(testview)
        slider.bringSubviewToFront(pageIndicator)
        
    
        
        // Do any additional setup after loading the view.
        
    }
    
    
    var cmOpen = false
    override func viewDidAppear(_ animated: Bool) {
      
    }
    override func viewDidLayoutSubviews() {
        
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
