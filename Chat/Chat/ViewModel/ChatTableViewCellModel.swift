//
//  ChatTableViewCellModel.swift
//  Chat
//
//  Created by Bimal@AppStation on 14/11/22.
//

import Foundation
import UIKit

enum ChatCelltype {
    case chatCell
    case imageCell
    case receiveChatCell
    case receiveImageCell
}

class ChatTableViewCellModel {
    var cellType: ChatCelltype = .chatCell
    var identifier: String = "chat.Cell"
    var chatDetails: Chat = Chat([:])
    
    init(strText: String, strCurrentTime: String, image: UIImage, cellType: ChatCelltype) {
        self.cellType = cellType
        self.chatDetails.enterText = strText
        self.chatDetails.image = image
        self.chatDetails.currentTime = strCurrentTime
        switch cellType {
        case .chatCell:
            identifier = "chat.Cell"
        case .imageCell:
            identifier = "image.Cell"
        case .receiveChatCell:
            identifier = "receiveChat.Cell"
        case .receiveImageCell:
            identifier = "receiveImage.Cell"
        }
    }
    
    func getChatDetail() -> String {
        return chatDetails.enterText
    }
    
    func getImage() -> UIImage {
        return chatDetails.image
    }
    func getCurrentTime() -> String {
        return chatDetails.currentTime
    }
}
