//
//  ChatViewController.swift
//  App3x 9.1 FlashChat
//
//  Created by Marwan Elbahnasawy on 27/05/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import ReverseExtension

class ChatViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    
    let db = Firestore.firestore()
    
    
    
    var messages : [Message] = [Message(userEmail: "shall be removed", message: "shall be removed", date: 0)]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cellID")
        
        
        messages.removeAll()
        
        tableView.re.delegate = self
        
        tableView.dataSource = self
        
        textField.delegate = self
        
        loadData()
        
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationItem.hidesBackButton = true
        
        navigationItem.title = "⚡️FlashChat"
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBlue
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Marker Felt", size: 30)]
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationController?.navigationBar.standardAppearance.backgroundColor = .systemBlue
        navigationController?.navigationBar.standardAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Marker Felt", size: 30)]
        
    }
    
    
    
    @IBAction func sendClicked(_ sender: UIButton) {
        finishedTyping()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        finishedTyping()
        return true
    }
    
    func finishedTyping() {
        if textField.text == "" {
            textField.placeholder = "Forgot to type?"
        }
        else {
            textField.placeholder = nil
            saveData()
            textField.text = ""
        }
    }
    
    func loadData(){
        db.collection("users").order(by: "date").addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.messages.removeAll()
                for document in querySnapshot!.documents {
                    self.messages.insert((Message(userEmail: document.data()["user email"] as! String, message: document.data()["message"] as! String, date: document.data()["date"] as! Double  )), at: 0)
                    
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    if self.messages.count >= 1 {
                    let indexPath = IndexPath(row: 0, section: 0)
                    self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
                    }
                }
            }
        }
        
    }
    
    func saveData(){
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: [
            "user email": Auth.auth().currentUser?.email ,
            "message": textField.text,
            "date": Date().timeIntervalSince1970
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        loadData()
    }
    

    @IBAction func logoutClicked(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
     do {
       try firebaseAuth.signOut()
         navigationController?.navigationBar.scrollEdgeAppearance = .none
         
         
         navigationController?.popToRootViewController(animated: true)
     } catch let signOutError as NSError {
       print("Error signing out: %@", signOutError)
     }
    }
    
    
}

extension ChatViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! TableViewCell
        cell.cellLabel.text = messages[indexPath.row].message
        cell.cellEmail.text = messages[indexPath.row].userEmail
        return cell
    }
}
