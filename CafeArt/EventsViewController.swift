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
import NVActivityIndicatorView

import ImageSlideshow
import VisualEffectView
import Cosmos
class EventsViewController: UIViewController {
    
    
    @IBOutlet weak var imageVw: UIImageView!
    
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
        TitleLable.text = Events[slider.currentPage].Title
        dateLable.text = Events[slider.currentPage].Date
        DescLable.text = Events[slider.currentPage].Description
        if( self.Events[self.slider.currentPage].Upcoming != true){
            self.endLable.isHidden = false
            self.endLable.text = "تمام شد"
            print("HIasdasdasd")
        }
        else
        {
            self.endLable.isHidden = true
            self.endLable.text =  ""
            
            
        }

        
    }
    var size = 0
    var imageSource : [ImageSource] = []
    var Events : [EventObject] = []
    var first = true
    @IBOutlet weak var endLable: UILabel!
    
    @IBOutlet weak var loader: NVActivityIndicatorView!
    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet weak var DescLable: UILabel!
    @IBOutlet weak var TitleLable: UILabel!
    @IBOutlet weak var cmView: UIView!
    @IBOutlet weak var testview: UIView!
    @IBOutlet weak var slider: ImageSlideshow!
    
    var v = false
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //setting gradient
        if(!v){
            v = true
            let Colors = Coloros.init()
            
            imageVw.setGradientBackground(colorOne: Colors.title_start_color, colorTwo: Colors.title_end_color,colorThree: Colors.title_end_color)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bluerview.blurRadius = 8
        loader.startAnimating()
        ServerCommands.init().getEvents(completion: { json in
            let des = json["Description"] as! String
            print(des)
            var i = 0
            if let data = des.data(using: .utf8) {
                do {
                    let json3 = try JSONSerialization.jsonObject(with: data,    options:JSONSerialization.ReadingOptions.mutableContainers) as!    NSDictionary
                    let UpcomingEvents = json3["UpcomingEvents"] as! NSArray
                    let PassedEvents = json3["UpcomingEvents"] as! NSArray
                    if((UpcomingEvents.count + PassedEvents.count) < 2)
                    {
                        self.testview.isHidden = true
                    }
                    for event2 in UpcomingEvents{
                        
                            i = i + 1
                            var eventObject = EventObject()
                            let event2 = event2 as! NSDictionary
                            let event = event2["Event"] as! NSDictionary
                            let image = event["ImageUrl"] as! String
                            eventObject.Date = event["Date"] as! String
                            eventObject.Upcoming = true
                            eventObject.Description = event["Description"] as! String
                            eventObject.Title = event["Title"] as! String
                            self.Events.append(eventObject)
                        DispatchQueue.main.async {
                            if(self.first){
                            self.TitleLable.text = self.Events[self.slider.currentPage].Title
                            self.dateLable.text = self.Events[self.slider.currentPage].Date
                            self.DescLable.text = self.Events[self.slider.currentPage].Description
                                self.first = false
                                if( self.Events[self.slider.currentPage].Upcoming != true){
                                    self.endLable.isHidden = false
                                    self.endLable.text = "تمام شد"
                                    print("HIasdasdasd")
                                }
                                else
                                {
                                    self.endLable.isHidden = true
                                    self.endLable.text =  ""

                                    
                                }

                            }
                            
                            
                        }
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
                                
                            }
                            
                        }, unauthorized: { e in
                            
                        }, onError:{ e in
                            
                        })
                        
                        
                    }
                    for event2 in PassedEvents{
                        DispatchQueue.main.async {
                            i = i + 1
                            var eventObject = EventObject()
                            let event2 = event2 as! NSDictionary
                            let event = event2["Event"] as! NSDictionary
                            let image = event["ImageUrl"] as! String
                            eventObject.Date = event["Date"] as! String
                            eventObject.Description = event["Description"] as! String
                            eventObject.Title = event["Title"] as! String
                            eventObject.Upcoming = false
                            self.Events.append(eventObject)
                            if(self.first){
                                self.TitleLable.text = self.Events[self.slider.currentPage].Title
                                self.dateLable.text = self.Events[self.slider.currentPage].Date
                                self.DescLable.text = self.Events[self.slider.currentPage].Description
                                self.first = false
                                if( self.Events[self.slider.currentPage].Upcoming != true){
                                    self.endLable.isHidden = false
                                }
                                else
                                {
                                    self.endLable.isHidden = true
                                    
                                }
                                
                            }
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
                                    if(i == ( PassedEvents.count + UpcomingEvents.count) ){
                                        print("HasddI\(i)")
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
                
            }        }, unauthorized: { e in
            
        }) { e in
            
        }
        let pageIndicator = UIPageControl()
        let Colors = Coloros.init()
        pageIndicator.currentPageIndicatorTintColor = Colors.DarkColor
        pageIndicator.pageIndicatorTintColor = Colors.tintColor
      
        ui_scroll_view.keyboardDismissMode = .onDrag
        slider.pageIndicator = pageIndicator
        slider.didEndDecelerating = x
 
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
   
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
}
