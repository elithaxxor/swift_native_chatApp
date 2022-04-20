//
//  ChatViewController.swift
//  FlashChat
//
//  Created by a-robota on 4/19/22.
//
// https://firebase.google.com/docs/ios/setup
// https://github.com/firebase/firebase-ios-sdk
// main()
//(for pod)
// pod 'FirebaseCore', :git => 'https://github.com/firebase/firebase-ios-sdk.git', :branch => 'master'
//pod 'FirebaseFirestore', :git => 'https://github.com/firebase/firebase-ios-sdk.git', :branch => 'master'

// .getDocument (single fetch) .addSnapshotListener
//

import UIKit
import Firebase
// import IQKeyboardManagerSwift // Keyboard context mgr




// tableviewDatasource vs
class ChatViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView! // displays messages [screen after login/register]
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    
    // [Messages, to be populated]
    var messages: [Message] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // header
        title =  "[NOBDOYLIKESME]"
        navigationItem.hidesBackButton = true // Hides the back button on the toolbar
        // tableView Init (models for messages view [reuse to recycle data] )
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        loadMessages() //call to load the message s
    }
    
    // to send msg, after using button
    @IBAction func sendPressed(_ sender: UIButton) {
        print("User msg \(messageTextfield.text)")
        
        if let msgBody = messageTextfield.text, let msgSender = Auth.auth().currentUser?.email {
            db.collection(K.userInfo.collectionName).addDocument(data: [
                
                
                
                K.userInfo.sendField: msgSender, // message literal oo
                K.userInfo.bodyField: msgBody, // body text
                K.userInfo.dateField: Date().timeIntervalSince1970 // datefield -> point of reference for message-array for ordering.
            ])
            { (error) in
                if let e = error {
                    print ("DB error (firstore) \(e)")
                    
                } else { // store message and clear input field
                    print("Msg stored to db")
                    DispatchQueue.main.async{
                        self.messageTextfield.text = ""
                    }}
            }
        }
    }
    
    
    
    func loadMessages() {
        self.messages = [] //messages will be appended to (querySnapshotSocuments)
        
        db.collection(K.userInfo.collectionName)
            .order(by: K.userInfo.dateField)
            .addSnapshotListener { (querySnapshot, error) in
                
                self.messages = []
                
                if let e = error {
                    print("error recv data from firestone. \(e)")
                    
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for d in snapshotDocuments {
                            let data = d.data()
                            if let msgSender = data [K.name.senderField] // retrv declared username from memory
                                as? String,
                               
                                let msgBody = data[K.name.bodyField] as String { // retrv msg from fieldView and appends to messages array
                                let newMsg=msg(sender: msgSender, body: msgBody)
                                self.messages.append(newMessage)
                                
                                // async queue
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                    // refresh feed after message recv.
                                    let indexPath = IndexPath(row: self.messages.count - 1, section: 0 )
                                    self.tableView.scrollToView(at: indexPath, at: .top, animated: true)
                                }
                            }
                        }
                    }
                }
            }
    }
    
    
    // to log out (goes to welcome view)
    // Pop to ro viewcontroller method (navigationController.pop)
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}





// [UITableViewDataSource] --> display controller
extension ChatViewController: UITableViewDataSource {
    
    
    //[view] --> [logic]--> array.count == # of cell s
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(" Chat Count: \(messages.count )")
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath ) as!  MessageCell
        cell.label.text = message.body
        
        // [Logic] --> conditional to ID message sender
        
        if message.sender == Auth.auth().currentUser?.email {
            
            cell.leftImgMsg.isHidden = true
            cell.rightImgMsg.isHidden = false
            cell.msgBubble.backgroundColor = UIColor(named: K.uiScheme.lightPurple)
            cell.label.textColor = UIColor(named: K.uiScheme.purple)
            
        } else { // sender
            cell.leftImgMsg.isHidden = true
            cell.rightImgMsg.isHidden = false
            cell.msgBubble.backgroundColor = UIColor(named: K.uiScheme.lightPurple)
            cell.label.textColor = UIColor(named: K.uiScheme.purple)
        }
        
        return cell
    }
}




//
//        // SubView, called from  UIDataSource
//        extension ChatViewController: UITableViewDelegate {
//            func tableView(_ UITableView, didSelectRowAt indexPath: IndexPath)
//            {
//                print(indexPath.row)
//                tableView.text = indexPath.row
//            }
//        }
//
