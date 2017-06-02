//
//  ViewController.swift
//  SQLite_Contact_List
//
//  Created by Trevor MacGregor on 2017-06-01.
//  Copyright © 2017 TeevoCo. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var contactsTableView: UITableView!
    
    fileprivate var contacts = [Contact]()
    fileprivate var selectedContact: Int?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsTableView.dataSource = self
        contactsTableView.delegate = self
        
        contacts = StephencelisDB.instance.getContacts()
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //MARK:Button actions
    
    @IBAction func addButtonClicked(_ sender: Any) {
        let name = nameTextField.text ?? ""
        let phone = phoneTextField.text ?? ""
        let address = addressTextField.text ?? ""
        
            if let id = StephencelisDB.instance.addContact(cname: name, cphone: phone, caddress: address)  {
                // Add contact in the tableview
                let contact = Contact(id: id, name: name, phone: phone, address: address)
                contacts.append(contact)
                
                contactsTableView.insertRows(at: [IndexPath(row: contacts.count-1, section: 0)], with: .fade)
//                let indexPath:IndexPath = IndexPath(row:(self.contacts.count - 1), section:0)
//                contactsTableView.insertRows(at: [indexPath], with: .fade)
            }
}
    
    @IBAction func updateButtonClicked(_ sender: Any) {
        if selectedContact != nil{
            let id = contacts[selectedContact!].id
            let contact = Contact(
                id: id,
                name: nameTextField.text ?? "",
                phone: phoneTextField.text ?? "",
                address: addressTextField.text ?? "")
            
            StephencelisDB.instance.updateContact(cid: id, newContact: contact)
            
            contacts.remove(at: selectedContact!)
            contacts.insert(contact, at: selectedContact!)
            
            
            contactsTableView.reloadData()
    }else{
    print("no item selected")
    }
}
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        if selectedContact != nil {
            StephencelisDB.instance.deleteContact(cid: contacts[selectedContact!].id)

            contacts.remove(at: selectedContact!)
            contactsTableView.deleteRows(at: [IndexPath(row: selectedContact!, section: 0)], with: .fade)
//            let indexPath:IndexPath = IndexPath(row:(selectedContact)!, section:0)
//            contactsTableView.deleteRows(at: [indexPath], with: .fade)
            
        }else{
            print("no item selected")
        }
    }
    
    @IBAction func newButtonClicked(_ sender: Any) {
        nameTextField.text = ""
        phoneTextField.text = ""
        addressTextField.text = ""
        
    }
    
    
    //MARK:TableView Functions
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        nameTextField.text = contacts[indexPath.row].name
        phoneTextField.text = contacts[indexPath.row].phone
        addressTextField.text = contacts[indexPath.row].address
        
        selectedContact = indexPath.row
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell")!
        var label: UILabel?
        label = cell.viewWithTag(1) as? UILabel // Name label
        label?.text = contacts[indexPath.row].name
        
        label = cell.viewWithTag(2) as? UILabel // Phone label
        label?.text = contacts[indexPath.row].phone
        
        label = cell.viewWithTag(3) as? UILabel // Address label
        label?.text = contacts[indexPath.row].address
        
        return cell
    }

    
    
    
}
