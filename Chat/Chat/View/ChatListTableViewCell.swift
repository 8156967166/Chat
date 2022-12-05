//
//  ChatListTableViewCell.swift
//  Chat
//
//  Created by Bimal@AppStation on 14/11/22.
//

import UIKit

class ChatListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelInChatList: UILabel!
    
    var cellModel: ChatListTableViewCellModel! {
        didSet {
            setChatListItems()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setChatListItems() {
        labelInChatList.text = cellModel.getChatListDetail()
    }
}
