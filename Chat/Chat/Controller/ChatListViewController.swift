//
//  ViewController.swift
//  Chat
//
//  Created by Bimal@AppStation on 14/11/22.
//

import UIKit

class ChatListViewController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variable
    
    var chatListArry:[ChatListTableViewCellModel] = []
    var searchArray = [ChatListTableViewCellModel]()
    // MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setChatListModel()
    }
    
    // MARK: - Functions
    
    func setChatListModel() {
        let name1 = ChatListTableViewCellModel(strName: "Adya", cellType: .chatListCell)
        let name2 = ChatListTableViewCellModel(strName: "Deepa", cellType: .chatListCell)
        let name3 = ChatListTableViewCellModel(strName: "Dhanya", cellType: .chatListCell)
        let name4 = ChatListTableViewCellModel(strName: "Isha", cellType: .chatListCell)
        let name5 = ChatListTableViewCellModel(strName: "Amal", cellType: .chatListCell)
        let name6 = ChatListTableViewCellModel(strName: "Amit", cellType: .chatListCell)
        let name7 = ChatListTableViewCellModel(strName: "Kalyani", cellType: .chatListCell)
        let name8 = ChatListTableViewCellModel(strName: "Vishnu", cellType: .chatListCell)
        let name9 = ChatListTableViewCellModel(strName: "Hari", cellType: .chatListCell)
        let name10 = ChatListTableViewCellModel(strName: "Nisha", cellType: .chatListCell)
        let name11 = ChatListTableViewCellModel(strName: "Govind", cellType: .chatListCell)
        let name12 = ChatListTableViewCellModel(strName: "Bijoy", cellType: .chatListCell)
        let name13 = ChatListTableViewCellModel(strName: "Navin", cellType: .chatListCell)
        let name14 = ChatListTableViewCellModel(strName: "Mridula", cellType: .chatListCell)
        let name15 = ChatListTableViewCellModel(strName: "Deepak", cellType: .chatListCell)
    
        chatListArry = [name1, name2, name3, name4, name5, name6, name7, name8, name9, name10, name11, name12, name13, name14, name15]
    }
}

// MARK: - TableView
extension ChatListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatListArry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = chatListArry[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.identifier, for: indexPath) as! ChatListTableViewCell
        cell.cellModel = cellModel
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let receivedModel = chatListArry[indexPath.row]
        self.performSegue(withIdentifier: "ChatViewController", sender: receivedModel)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ChatViewController") {
            let model = sender as! ChatListTableViewCellModel
            if let chatVc = segue.destination as? ChatViewController {
                chatVc.getPersonNameFromChatList = model.chatDetails.personName
            }
        }
    }
}
