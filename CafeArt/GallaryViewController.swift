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
import NVActivityIndicatorView
class GallaryViewController: UIViewController {
    
    @IBOutlet weak var imageVw: UIImageView!
    
    
    
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
    @IBOutlet weak var loader: NVActivityIndicatorView!
    
    @IBOutlet weak var testview: UIView!
    @IBOutlet weak var slider: ImageSlideshow!
    var z = false
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //setting gradient
        if(!z){
            z = true
            let Colors = Coloros.init()
            
            imageVw.setGradientBackground(colorOne: Colors.title_start_color, colorTwo: Colors.title_end_color,colorThree: Colors.title_end_color)
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loader.startAnimating()
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
                                    self.size = self.slider.images.count
                                    self.indicatorLable.text = "\(self.slider.currentPage+1) از \(self.size)"
                                    self.indicatorLable.isHidden = false
                                    self.testview.isHidden = false
                                    self.slider.reloadInputViews()
                                    print(i)
                                    print(json3.count)
                                    if(i == json3.count){
                                        
                                        self.loader.isHidden = true
                                    }
                                    
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
       
        
        slider.pageIndicator = nil
        slider.contentScaleMode = .scaleAspectFill
        slider.bringSubviewToFront(testview)
        slider.bringSubviewToFront(pageIndicator)
        
    
        
        // Do any additional setup after loading the view.
        
    }
    
    
    var cmOpen = false
    override func viewDidAppear(_ animated: Bool) {
      
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
