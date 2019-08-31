//
//  testViewController.swift
//  CafeArt
//
//  Created by Keyvan Yaghoubian on 8/11/19.
//  Copyright © 2019 Keyvan Yaghoubian. All rights reserved.
//

import UIKit
import ImageSlideshow
import VisualEffectView
import Cosmos
import NVActivityIndicatorView
class testViewController: UIViewController {
    
    @IBOutlet weak var imageVw: UIImageView!
    
    
    @IBOutlet weak var editText: UITextField!
    let sharedPref = UserDefaults.standard

    var items : [itemObject] =  []
    var rowid = 0

    @IBAction func sendmsg(_ sender: Any) {
        cmOpen = false
        print("HI")
        let token = sharedPref.object(forKey: "UserType") as! String
        if(token == "activated"){
           

        ServerCommands.init().Comment(id: items[rowid].Id, Comment1: editText.text! , Rate: Int(stars.rating), completion: { x in
            print(x)
        }, unauthorized: { e in
            
        }) { e in
            
        }

        
        let ratio : CGFloat =  -CGFloat( self.cmView.frame.width - self.cmView.frame.height + 20)
        print(ratio)
        self.widthconstraint.constant = ratio
        UIView.animate(withDuration: 0.5,
                       animations: {
                        
                        self.view.layoutIfNeeded()
                        
        },
                       completion: { _ in
                        usleep(300000)
                        
                        
                        UIView.animate(withDuration: 1,delay:0, animations: {
                            self.sendmsgImage.image = UIImage(named: "Group-198")
                        },completion: { _ in
                            usleep(500000)

                            UIView.animate(withDuration: 0.5,delay:0, animations: {
                                var headerTransform = CATransform3DIdentity
                                headerTransform = CATransform3DTranslate(headerTransform, 0,0 , 0)
                                var headerTransform2 = CATransform3DIdentity
                                headerTransform2 = CATransform3DTranslate(headerTransform2, 0,50 , 0)
                                self.cmView.layer.transform = headerTransform2
                                self.parent2.layer.transform = headerTransform
                            },completion: { _ in
                                self.cmView.transform = CGAffineTransform.identity
                                let ratio : CGFloat =  -CGFloat( self.cmView.frame.width - self.cmView.frame.height + 20)
                                print(ratio)
                                self.widthconstraint.constant = ratio
                                
                                                       self.sendmsgImage.image = UIImage(named: "Group-197")
                            })
                            
                        })
        })
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        ui_scroll_view.contentInset = contentInset
        editText.endEditing(true)
        ui_scroll_view.isScrollEnabled = false
        dismissKeyboard()
        }
        else{
            let target = getViewController(id: "SignUpViewControllerPoPup") as! SignUpViewControllerPoPup
            self.present(target, animated: true) {
                
            }
        }
    }
    @IBOutlet weak var ui_scroll_view: UIScrollView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var DescriptionLable: UILabel!
    @IBOutlet weak var stars: CosmosView!
    @IBOutlet weak var bluerview: VisualEffectView!
    var isOpen = false
    
    @IBAction func showMore(_ sender: Any) {
        if(isOpen){
            isOpen = false
            DescriptionLable.numberOfLines = 2
            bishtar.text = "توضیحات بیشتر"
        }
            
        else{
            isOpen = true
            DescriptionLable.numberOfLines = 0
            bishtar.text =  "بستن توضیحات"

        }
        print("hi")
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    func x() -> () {
        print("HI")
        print(slider.currentPage)
    }
    
    
    func convertEngNumToPersianNum(num: String)->String{
        //let number = NSNumber(value: Int(num)!)
        let format = NumberFormatter()
        format.locale = Locale(identifier: "fa_IR")
        let number =   format.number(from: num)
        let faNumber = format.string(from: number!)
        return faNumber!
        
    }
    @IBOutlet weak var priceLable: UILabel!
    @IBOutlet weak var likesCountLable: UILabel!
    @IBOutlet weak var widthconstraint: NSLayoutConstraint!
    @IBOutlet weak var cmView: UIView!
    @IBAction func backp(_ sender: Any) {
        dismiss(animated: true)
    }
    var liked : Bool = false
    @IBAction func likeaction(_ sender: Any) {
        let token = sharedPref.object(forKey: "UserType") as! String
        if(token == "activated"){
        ServerCommands.init().Like(id: items[rowid].Id, completion: { x in
            print(x)
        }, unauthorized: { e in
            
        }) { e in
            
        }
        if(liked){
            
            liked=false
            likecount = likecount - 1
            items[rowid].isLiked = false
            likesCountLable.text = "\(likecount)" as String
            items[rowid].LikesCount = likecount
            likeImage.image = UIImage(named: "like(1)")

            
        }
        else{
            liked = true
            likecount = likecount + 1
            likeImage.image = UIImage(named: "like2")
            items[rowid].isLiked = true
            items[rowid].LikesCount = likecount
            likesCountLable.text = "\(likecount)" as String

        }
        }
        else{
            let target = getViewController(id: "SignUpViewControllerPoPup") as! SignUpViewControllerPoPup
            self.present(target, animated: true) {
                
            }
        }

        
    }
    @IBOutlet weak var loader: NVActivityIndicatorView!
    var likecount = 0
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var bishtar: UILabel!
let pageIndicator = UIPageControl()
    @IBOutlet weak var testview: UIView!
    @IBOutlet weak var width: NSLayoutConstraint!
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var slider: ImageSlideshow!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        bluerview.blurRadius = 8
        let item = items[rowid]
        liked = item.isLiked
        testview.isHidden = true
        print(liked)
        
        if(!liked){
            
            likeImage.image = UIImage(named: "like(1)")
            
            
        }
        else{
           
            likeImage.image = UIImage(named: "like2")
            
            
        }
       titleLable.text = item.Title
        DescriptionLable.text = item.Description
        var imageSource : [ImageSource] = []
        priceLable.text = "\(convertEngNumToPersianNum(num: "\(item.Price!)")) تومان"
        likesCountLable.text = "\(item.LikesCount!)" as String
        likecount = item.LikesCount
        var i = 0
        loader.startAnimating()
        if (item.Gallery.count<2){
            testview.isHidden = true

        }

        for x in item.Gallery {
            print("HI assss")
            print(i)
            print("d\(item.Gallery.count)")
            ServerCommands.init().GetImage(Link: x as! String, completion: { json in
                DispatchQueue.main.async {
                    i = i + 1

                    let img2 = self.base64Convert(base64String: json)
                    
                    imageSource.append(ImageSource(image: img2))
                    self.slider.setImageInputs(imageSource)
                    self.width.constant = self.pageIndicator.bounds.width + 25
                    if(i>1){
                        self.testview.isHidden = false
                        print("HI")

                    }
                    if(i == (item.Gallery.count )){
                        print("HI Gooozo")
                        
                        self.loader.isHidden = true
                        self.loader.stopAnimating()
                    }


                    self.slider.reloadInputViews()
                }
                
            }, unauthorized: { e in
                
            }) { e in
                
            }
            
            
        }
        
        
        
        let Colors = Coloros.init()
        pageIndicator.currentPageIndicatorTintColor = Colors.DarkColor
        pageIndicator.pageIndicatorTintColor = Colors.tintColor
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:UIResponder.keyboardWillHideNotification, object: nil)
        ui_scroll_view.keyboardDismissMode = .onDrag
        slider.pageIndicator = pageIndicator
        slider.didEndDecelerating = x
        slider.setImageInputs(imageSource)
        slider.pageIndicatorPosition = PageIndicatorPosition(horizontal: .center, vertical: .customTop(padding: 50+20+2.5))
        slider.contentScaleMode = .scaleAspectFill
        height.constant = pageIndicator.bounds.height + 5
        width.constant = pageIndicator.bounds.width + 25
        testview.cornerRadius = height.constant/2
        testview.backgroundColor = UIColor.white
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
    @IBOutlet weak var sendmsgImage: UIImageView!
    
    @objc func respondToSwipeGesture(gesture :UISwipeGestureRecognizer) {
        print("HIkiri")
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                print("Swiped right")
            case UISwipeGestureRecognizer.Direction.down:
                print("Swiped down")
               
                if(isOpen){
                    
                    isOpen = false
                    DescriptionLable.numberOfLines = 2
                    bishtar.text = "توضیحات بیشتر"

                }
                else{
                    if(cmOpen){
                        cmOpen = false
                        
                        var headerTransform = CATransform3DIdentity
                            headerTransform = CATransform3DTranslate(headerTransform, 0,0 , 0)
                        if #available(iOS 11, *) {
                            UIView.animate(withDuration: 0.5, animations: {
                                self.parent2.layer.transform = headerTransform
                                
                            }, completion: { _ in
                            })
                        }

                    }
                }
            case UISwipeGestureRecognizer.Direction.left:
                print("Swiped left")
            case UISwipeGestureRecognizer.Direction.up:
                print("Swiped up")
                if(!cmOpen){
                    cmOpen = true
                    var headerTransform = CATransform3DIdentity
                    headerTransform = CATransform3DTranslate(headerTransform, 0,-120 , 0)
                    if #available(iOS 11, *) {
                        UIView.animate(withDuration: 0.5, animations: {
                            self.parent2.layer.transform = headerTransform
                            
                        }, completion: { _ in
                        })
                    }
                }
                else{
                    if(!isOpen)
                    {
                        isOpen = true
                        DescriptionLable.numberOfLines = 0
                        bishtar.text =  "بستن توضیحات"

                    }
                    
                }
            default:
                break
            }
        }
        
            

    }
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        print(self.cmView.frame.size)
        let cmwitdh = Double(cmView.frame.size.width) - 40
        let test = Double(stars.settings.starSize * 5)
        let test2 = cmwitdh - test
        stars.settings.starMargin = test2/4
       
    }
    @IBOutlet weak var parent2: UIView!
    
    var cmOpen = false
    @IBAction func commentAction(_ sender: Any) {
        var headerTransform = CATransform3DIdentity

        if(cmOpen){
            cmOpen = false
            dismissKeyboard()
            
            let contentInset:UIEdgeInsets = UIEdgeInsets.zero
            ui_scroll_view.contentInset = contentInset
            headerTransform = CATransform3DTranslate(headerTransform, 0,0 , 0)
            if #available(iOS 11, *) {
                UIView.animate(withDuration: 0.5, animations: {
                    self.parent2.layer.transform = headerTransform
                    
                }, completion: { _ in
                })
            }

            
        }
        else{
            cmOpen = true
            headerTransform = CATransform3DTranslate(headerTransform, 0,-120 , 0)
            if #available(iOS 11, *) {
                UIView.animate(withDuration: 0.5, animations: {
                    self.parent2.layer.transform = headerTransform
                    
                }, completion: { _ in
                })
            }
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
    @objc func keyboardWillShow(notification:NSNotification){
        print("Hi")
        ui_scroll_view.isScrollEnabled = true

        var userInfo = notification.userInfo!

        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.ui_scroll_view.contentInset
        contentInset.bottom = keyboardFrame.size.height
        ui_scroll_view.contentInset = contentInset
    }
    @objc func keyboardWillHide(notification:NSNotification){
        print("called")
        

        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        ui_scroll_view.contentInset = contentInset
    }
    

}
