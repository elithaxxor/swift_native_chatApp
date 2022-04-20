//
//  MessageCell.swift
//  FlashChat
//
//  Created by a-robota on 4/19/22.
//


import UIKit

class MessageCell: UITableViewCell {

    // use this method to construct message cells
    
    @IBOutlet weak var msgBubble: UIView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet var leftImgMsg: UIImageView!
    @IBOutlet var rightImgMsg: UIImageView!
    
    
    
    
    // Nib (Message Bubbles) init
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // msg bubble view options
        msgBubble.layer.cornerRadius = msgBubble.frame.size.height /  5
        
    }

    
        // Configure the view for the selected state

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
}
