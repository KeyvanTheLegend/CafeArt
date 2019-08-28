//
//  ItemsViewController.swift
//  CafeArt
//
//  Created by Keyvan Yaghoubian on 8/18/19.
//  Copyright © 2019 Keyvan Yaghoubian. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    func numberOfSelectionsInTableView (tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.width * 0.66
        
    }
    func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("HI")
        
        return items.count
        
    }
    var items : [itemObject] =  []

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storybord = UIStoryboard (name: "Main", bundle: nil)
        let target = storybord.instantiateViewController(withIdentifier:    "item") as! testViewController
        target.items = items
        target.rowid = indexPath.row
        self.present(target, animated: true, completion: nil)
    }
    
    @IBOutlet weak var mytable: UITableView!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cel", for:indexPath) as! CustomCell
        if items.count>0 {
            cell.loader.startAnimating()

            let obj = items[indexPath.row] as itemObject
            print(obj.Title)
            cell.titlelable.text = obj.Title
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            ServerCommands.init().GetImage(Link: obj.MenuImageUrl, completion: { json in
                print(json)
                DispatchQueue.main.async {
                    let img2 = self.base64Convert(base64String: json)
                    cell.backgroundimg.image = img2
                    cell.loader.isHidden = true
                    
                }
                
            }, unauthorized: { e in
                
            }) { e in
                
            }
        }
        print(cell.frame.width)
        print(cell.frame.height)
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mytable.separatorStyle = UITableViewCell.SeparatorStyle.none
       
        
        // Do any additional setup after loading the view.
    }
    @IBAction func backp(_ sender: Any) {
        dismiss(animated: true)
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
