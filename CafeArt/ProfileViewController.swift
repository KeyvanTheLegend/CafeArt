//
//  ProfileViewController.swift
//  CafeArt
//
//  Created by Keyvan Yaghoubian on 8/25/19.
//  Copyright © 2019 Keyvan Yaghoubian. All rights reserved.
//

import UIKit
import VisualEffectView

class ProfileViewController: UIViewController,UICollectionViewDelegate ,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SomeArray.count
    }
    var SomeArray : [FavObject] = []
    @IBOutlet weak var numberLable: UILabel!
    @IBOutlet weak var nameLable: UILabel!
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionviewCell", for:indexPath) as! FCell
        if(SomeArray.count>0){
            cell.loader.startAnimating()

            print(SomeArray)
            ServerCommands.init().GetImage(Link: SomeArray[indexPath.row].image, completion: { json in
                print(json)
                DispatchQueue.main.async {
                    let img2 = self.base64Convert(base64String: json)
                   cell.image.image = img2
                    
                    cell.loader.isHidden = true
                    
                }
                
            }, unauthorized: { e in
                
            }) { e in
                
            }
            
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = (collectionView.bounds.width - 45)/4.0
        let yourHeight = yourWidth
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
    var myname = ""
    var number = ""
    var NotHero : Bool = true
    @IBOutlet weak var BlurView: VisualEffectView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("HI")
        BlurView.blurRadius = 3
        if(NotHero){
            NotHero = false
        ServerCommands.init().profile(completion: { json in
            let array = json.value(forKey: "Description") as! String
            if let data = array.data(using: .utf8) {
                do {
                    let json3 = try JSONSerialization.jsonObject(with: data,    options:JSONSerialization.ReadingOptions.mutableContainers) as!    NSDictionary
                    DispatchQueue.main.async {
                        let x = json3["ProfileInfo"] as! NSDictionary
                        //print(x)
                        self.myname = x["Name"] as! String
                        self.number = x["PhoneNumber"] as! String

                      
                        let fav = json3["FavoriteItems"] as! NSArray
                        for item in fav {
                            let item = item as! NSDictionary
                            let myobject = FavObject()
                            myobject.id = item["_id"] as! String
                            let img1 = item["ItemImageUrl"] as! String

                            myobject.image = img1
                            //print(myobject.id)
                            self.SomeArray.append(myobject)
                            
                        }
                        self.nameLable.text = self.myname
                        self.numberLable.text = self.number
                        self.collectionViews.reloadData()
                        
                    }
                    
                    
                }
                catch{
                    print("not a valid json")
                }
            }
            
        }, unauthorized: { e in
            
        }) { e in
            
        }
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func editbtn(_ sender: Any) {
       let target =  getViewController(id: "EditViewController") as! EditViewController
        target.namevar = nameLable.text!
        target.numbervar = numberLable.text!
        self.present(target,animated: true)
        
    }
    @IBOutlet weak var collectionViews: UICollectionView!
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
