//
//  MenuViewController.swift
//  CafeArt
//
//  Created by Keyvan Yaghoubian on 8/17/19.
//  Copyright © 2019 Keyvan Yaghoubian. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class MenuViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var imageVw: UIImageView!
    
    
    
    @IBOutlet weak var dss: NVActivityIndicatorView!
    func numberOfSelectionsInTableView (tableView: UITableView) -> Int {
        return 1
    }
    @IBAction func backp(_ sender: Any) {
        dismiss(animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.width * 0.66

    }
    func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("HI")
        
        return Cats.count
        
    }
    @IBOutlet weak var loader2: NVActivityIndicatorView!
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = Cats[indexPath.row]
        ServerCommands.init().Items(rowId: "\(item.RowId!)", completion: { json in
            let array = json.value(forKey: "Description") as! String
            var items : [itemObject] =  []
            if let data = array.data(using: .utf8) {
                do {
                    let json3 = try JSONSerialization.jsonObject(with: data,    options:JSONSerialization.ReadingOptions.mutableContainers) as!    NSArray
                    for item in json3{
                        let data = item as! NSDictionary
                        let item = itemObject()
                        item.ItemImageUrl = data["ItemImageUrl"] as! String
                        item.MenuImageUrl = data["MenuImageUrl"] as! String
                        item.Title = data["Title"] as! String
                        item.RowId = data["RowId"] as! String
                        item.Gallery = data["Gallery"] as! NSArray
                        item.LikesCount = data["LikesCount"] as! Int
                        item.Likes = data["Likes"] as! NSArray
                        item.Price = data["Price"] as! Int
                        item.Description =  data["Description"] as! String
                        item.Id = data["_id"] as! String
                        item.isLiked = data["IsLiked"] as! Bool
                        print(item.Title)
                        
                        items.append(item)
                    }
                    DispatchQueue.main.async {
                        //reload data
                        let storybord = UIStoryboard (name: "Main", bundle: nil)
                        let target = storybord.instantiateViewController(withIdentifier:    "menu2") as! ItemsViewController
                        target.items = items
                        self.present(target, animated: true, completion: nil)
                        print("hi")
                    }
                    
                }
                catch{
                    print("not a valid json")
                }
                
            }
        }, unauthorized: { s in
            
        }) { e in
            
        }
    }
    
    @IBOutlet weak var mytable: UITableView!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cel", for:indexPath) as! CustomCell
        if Cats.count>0 {
            let obj = Cats[indexPath.row] as CatObejcts
            print(obj.Title)
            print(Cats.count)
            cell.titlelable.text = obj.Title
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            ServerCommands.init().GetImage(Link: obj.ImageUrl, completion: { json in
                print(json)
                DispatchQueue.main.async {
                     let img2 = self.base64Convert(base64String: json)
                    cell.backgroundimg.image = img2
                    cell.loader.isHidden = true
                    
                }
               
            }, unauthorized: { e in
                
            }) { e in
                
            }
            //let img2 = base64Convert(base64String: obj.LogoUrl)
        }
        print(cell.frame.width)
        print(cell.frame.height)
        cell.loader.startAnimating()
        return cell
    }
    

    @IBOutlet weak var dass: NVActivityIndicatorView!
    var Cats : [CatObejcts] = []
    var x = false
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //setting gradient
        if(!x){
            x = true
            let Colors = Coloros.init()

             imageVw.setGradientBackground(colorOne: Colors.title_start_color, colorTwo: Colors.title_end_color,colorThree: Colors.title_end_color)
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mytable.separatorStyle = UITableViewCell.SeparatorStyle.none
        loader2.startAnimating()
       
        ServerCommands.init().SendActivationCode(MobileNumber: "t", completion: { json in
            print("Hiasd")
            print(json)
            let array = json.value(forKey: "Description") as! String
            if let data = array.data(using: .utf8) {
                
                do {
                    
                    let json3 = try JSONSerialization.jsonObject(with: data,    options:JSONSerialization.ReadingOptions.mutableContainers) as!    NSArray
                    for item in json3{
                    let data = item as! NSDictionary
                    let item = CatObejcts()
                    item.ImageUrl = data["ImageUrl"] as! String
                    item.LogoUrl = data["ImageUrl"] as! String
                    item.Title = data["Title"] as! String
                    item.RowId = data["RowId"] as! Int
                    let mediaFile = data["ImageUrl"] as! String
                    print(item.Title)
                        self.Cats.append(item)
                    }
                    DispatchQueue.main.async {
                        //reload data
                        self.mytable.reloadData()
                        self.loader2.isHidden = true
                        print("hi")
                    }
                    
                    
                }
                catch{
                    print("not a valid json")
                }
                
            }
            
            /*
             let data = array[0] as! NSDictionary
             let mediaFile = data["ImageUrl"] as! String
             if let decodedData = Data(base64Encoded: mediaFile, options: .ignoreUnknownCharacters) {
             let image = UIImage(data: decodedData)
             DispatchQueue.main.async {
             self.testimage.image = image
             }
             }*/
        }, unauthorized: { s in
            
        }) { e in
            
        }
        // Do any additional setup after loading the view.
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
