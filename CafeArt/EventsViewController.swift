//
//  EventsViewController.swift
//  CafeArt
//
//  Created by Keyvan Yaghoubian on 8/17/19.
//  Copyright © 2019 Keyvan Yaghoubian. All rights reserved.
//

import UIKit

//
//  EventsViewController.swift
//  CafeArt
//
//  Created by Keyvan Yaghoubian on 8/17/19.
//  Copyright © 2019 Keyvan Yaghoubian. All rights reserved.
//

import UIKit

import ImageSlideshow
import VisualEffectView
import Cosmos
class EventsViewController: UIViewController {
    
    @IBOutlet weak var tozihatbishtarLable: UILabel!
    @IBAction func backp(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBOutlet weak var ui_scroll_view: UIScrollView!
    @IBOutlet weak var DescriptionLable: UILabel!
    @IBOutlet weak var stars: CosmosView!
    @IBOutlet weak var bluerview: VisualEffectView!
    var isOpen = false
    
    @IBAction func showMore(_ sender: Any) {
        if(isOpen){
            isOpen = false
            DescriptionLable.numberOfLines = 2
            tozihatbishtarLable.text  = "توضیحات بیشتر"

        }
            
        else{
            isOpen = true
            DescriptionLable.numberOfLines = 0
            tozihatbishtarLable.text  = "بستن توضیحات"

        }
        print("hi")
    }
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
    @IBOutlet weak var cmView: UIView!
    @IBOutlet weak var testview: UIView!
    @IBOutlet weak var slider: ImageSlideshow!
    override func viewDidLoad() {
        super.viewDidLoad()
        bluerview.blurRadius = 8
        
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
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipeRight)
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(swipeUp)
        
        // Do any additional setup after loading the view.
        
    }
    
    @objc func respondToSwipeGesture(gesture :UISwipeGestureRecognizer) {
        print("HI")
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                print("Swiped right")
            case UISwipeGestureRecognizer.Direction.down:
                print("Swiped down")
                
                if(isOpen){
                    
                    isOpen = false
                    DescriptionLable.numberOfLines = 2
                    tozihatbishtarLable.text  = "توضیحات بیشتر"
                    
                }
                else{

                }
            case UISwipeGestureRecognizer.Direction.left:
                print("Swiped left")
            case UISwipeGestureRecognizer.Direction.up:
                print("Swiped up")
                if(!isOpen){
                    isOpen = true
                    DescriptionLable.numberOfLines = 0
                    tozihatbishtarLable.text  = "بستن توضیحات"

                }
                else{
                    if(!isOpen)
                    {
                       
                    }
                    
                }
            default:
                break
            }
        }
        
        
        
    }
    var cmOpen = false
    override func viewDidAppear(_ animated: Bool) {
        print(self.cmView.frame.size)
        let cmwitdh = Double(cmView.frame.size.width) - 40
        let test = Double(stars.settings.starSize * 5)
        let test2 = cmwitdh - test
        stars.settings.starMargin = test2/4
        
    }
    @IBOutlet weak var parent2: UIView!
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
