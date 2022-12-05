//
//  ChatViewController.swift
//  Chat
//
//  Created by Bimal@AppStation on 14/11/22.
//

import UIKit

class ChatViewController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var labelPersonName: UILabel!
    @IBOutlet weak var messageTextBox: UITextField!
    @IBOutlet weak var bottomMessageHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mySegmentedControl: UISegmentedControl!
    
    // MARK: - Variable
    
    var getPersonNameFromChatList: String!
    var messageArray:[ChatTableViewCellModel] = []
    var setImage = UIImage()
    var isClickImageAttachButton = Bool()
   
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelPersonName.text = getPersonNameFromChatList
        messageTextBox.delegate = self
        // Do any additional setup after loading the view.
        notificationKeyboard()
        setSegmentedControl()
    }
    
    // MARK: - function
    
    func setSegmentedControl() {
        mySegmentedControl.selectedSegmentIndex = 0
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        let titleTextAttributesSelected = [NSAttributedString.Key.foregroundColor: UIColor.black]
        mySegmentedControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
        mySegmentedControl.setTitleTextAttributes(titleTextAttributesSelected, for: .selected)

        self.navigationController?.navigationItem.hidesBackButton = true
        mySegmentedControl.subviews.forEach { subview in
          subview.backgroundColor = .white
        }
        mySegmentedControl.clipsToBounds = true
    }
    
    func createChatModel() {
        let segmentIndex = mySegmentedControl.selectedSegmentIndex
        let date = Date()
        let todayFormatter = DateFormatter()
        todayFormatter.dateFormat = "h:mm a"
        let todayString = todayFormatter.string(from: date)
        if segmentIndex == 0 {
            messageArray.append(ChatTableViewCellModel(strText: "\(String(describing: messageTextBox.text!))", strCurrentTime: "\(todayString)", image: UIImage(), cellType: .chatCell))
        }
        else if segmentIndex == 1 {
            messageArray.append(ChatTableViewCellModel(strText: "\(String(describing: messageTextBox.text!))", strCurrentTime: "\(todayString)", image: UIImage(), cellType: .receiveChatCell))
        }
       
    }
    
    func notificationKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - ButtonActions
    
    @IBAction func buttonActionCloseArrow(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonActionSendMessage(sender: UIButton) {
        isClickImageAttachButton = true
        let segmentIndex = mySegmentedControl.selectedSegmentIndex
        
        if segmentIndex == 0 {
            
            if messageTextBox.text?.isEmpty == false {
                createChatModel()
                let indexPath = IndexPath(row: messageArray.count - 1, section: 0)
                tableView.beginUpdates()
                tableView.insertRows(at: [indexPath], with: .right)
                tableView.endUpdates()
//                view.endEditing(true)
            }
            else {
                print("Error")
            }
        }
        else if segmentIndex == 1 {
            if messageTextBox.text?.isEmpty == false {
                createChatModel()
                let indexPath = IndexPath(row: messageArray.count - 1, section: 0)
                tableView.beginUpdates()
                tableView.insertRows(at: [indexPath], with: .left)
                tableView.endUpdates()
//                view.endEditing(true)
            }
            else {
                print("Error")
            }
        }
        messageTextBox.text = ""
//        tableView.reloadData()
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.messageArray.count-1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    @IBAction func buttonActionImageAttach(sender: UIButton) {
//        isClickImageAttachButton = true
        showAlert()
    }

    // MARK: - KeyBoardDelegates
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        if let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyBoardHeight = keyboardSize.height
            bottomMessageHeight.constant = keyBoardHeight
        }
    }

    @objc func keyboardWillHide(notifiaction: NSNotification) {
        bottomMessageHeight.constant = 0
    }
}

// MARK: - TextFieldDelegates

extension ChatViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        self.view.endEditing(true)
        return true;
    }
}

// MARK: - ImageDelegate

extension ChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showAlert() {
        let alertController = UIAlertController(title: "", message: "Choose Any Option", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(_ action: UIAlertAction) in self.getImage(fromSourceType: .camera) }))
        alertController.addAction(UIAlertAction(title: "Gallery", style: .default, handler: {(_ action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
            
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        setImage = tempImage
        let segmentIndex = mySegmentedControl.selectedSegmentIndex
        let date = Date()
        let todayFormatter = DateFormatter()
        todayFormatter.dateFormat = "h:mm a"
        let todayString = todayFormatter.string(from: date)
        if segmentIndex == 0 {
//            if isClickImageAttachButton == true {
            messageArray.append(ChatTableViewCellModel(strText: "", strCurrentTime: "\(todayString)", image: setImage, cellType: .imageCell))
            let indexPath = IndexPath(row: messageArray.count - 1, section: 0)
            tableView.beginUpdates()
            tableView.insertRows(at: [indexPath], with: .right)
            tableView.endUpdates()
//            }
        }
        else if segmentIndex == 1 {
            
//            if isClickImageAttachButton == true {
            messageArray.append(ChatTableViewCellModel(strText: "", strCurrentTime: "\(todayString)", image: setImage, cellType: .receiveImageCell))
            let indexPath = IndexPath(row: messageArray.count - 1, section: 0)
            tableView.beginUpdates()
            tableView.insertRows(at: [indexPath], with: .left)
            tableView.endUpdates()
//            }
        }
        
//        if let objModels = messageArray.first(where: {$0.cellType == .imageCell}) {
//            objModels.chatDetails.image = tempImage
//        }
     
//        tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.messageArray.count-1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
     
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - TableView

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        let segmentIndex = mySegmentedControl.selectedSegmentIndex
        
        if segmentIndex == 0 {
            returnValue = messageArray.count
        }
        else if segmentIndex == 1 {
            returnValue = messageArray.count
        }
        
        return returnValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellModel = messageArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.identifier, for: indexPath) as! ChatTableViewCell
        let width = view.frame.size.width * 0.7
        cell.widthOfChatReceive?.constant = width
        cell.widthOfChatSend?.constant = width
        cell.cellModel = cellModel
        return cell
    }
    

//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let segmentIndex = mySegmentedControl.selectedSegmentIndex
//        if segmentIndex == 0 {
//
//            cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: 0)
//            UIView.animate(withDuration: 0.5, delay: 0.01 * Double(indexPath.row), options: [.curveEaseInOut], animations: {
//            cell.transform = CGAffineTransform(translationX: 0, y: 0)
//            })
//        }
//        else if segmentIndex == 1 {
//
//            cell.transform = CGAffineTransform(translationX: 0, y: cell.contentView.frame.height)
//            UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row), animations: {
//            cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: cell.contentView.frame.height)
//            })
//        }
//    }

}
