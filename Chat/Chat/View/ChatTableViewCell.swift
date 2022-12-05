//
//  ChatTableViewCell.swift
//  Chat
//
//  Created by Bimal@AppStation on 14/11/22.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelInChat: UILabel?
    @IBOutlet weak var imageInChat: UIImageView?
    @IBOutlet weak var widthOfChatSend: NSLayoutConstraint?
    @IBOutlet weak var widthOfChatReceive: NSLayoutConstraint?
    @IBOutlet weak var labelCurrentTimeSend: UILabel?
    @IBOutlet weak var labelCurrentTimeReceive: UILabel?
    @IBOutlet weak var labelCurrentTimeImageSnd: UILabel?
//    @IBOutlet weak var labelCurrentTimeImageSnd: UILabel?
    
    var cellModel: ChatTableViewCellModel! {
        didSet {
            setChatitems()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        widthOfChatSend?.constant = 0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setChatitems() {
        labelInChat?.text = cellModel.getChatDetail()
        imageInChat?.image = cellModel.getImage()
        labelCurrentTimeSend?.text = cellModel.getCurrentTime()
        labelCurrentTimeReceive?.text = cellModel.getCurrentTime()
        labelCurrentTimeImageSnd?.text = cellModel.getCurrentTime()
    }
}
