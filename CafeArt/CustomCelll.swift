//
//  CustomCellTableViewCell.swift
//  CafeArt
//
//  Created by Apple on 5/25/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import VisualEffectView
import NVActivityIndicatorView
class CustomCell: UITableViewCell {

    @IBOutlet weak var blurView: VisualEffectView!
    @IBOutlet weak var titlelable: UILabel!
    @IBOutlet weak var backgroundimg: UIImageView!
    public var url_img : String?
    public var url_logo : String?

    @IBOutlet weak var loader: NVActivityIndicatorView!
    @IBOutlet weak var back: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        

        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        blurView.blurRadius = 5
        blurView.roundCorners(corners: [.topLeft, .topRight], radius: 55)
        back.roundCorners(corners: [.topLeft, .topRight], radius: 55)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
