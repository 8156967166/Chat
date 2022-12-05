//
//  ChatListTableViewCellModel.swift
//  Chat
//
//  Created by Bimal@AppStation on 14/11/22.
//

import Foundation

enum ChatListCellType {
    case chatListCell
}

class ChatListTableViewCellModel {
    var cellType: ChatListCellType = .chatListCell
    var identifier: String = "chatList.Cell"
    var chatDetails: ChatList = ChatList([:])
    
    
    init(strName: String, cellType: ChatListCellType) {
        self.cellType = cellType
        self.chatDetails.personName = strName
        
        switch cellType {
        case .chatListCell:
            identifier = "chatList.Cell"
        }
    }
    
    func getChatListDetail() -> String {
        return chatDetails.personName
    }
}
