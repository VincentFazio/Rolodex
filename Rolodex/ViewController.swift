//
//  ViewController.swift
//  Rolodex
//
//  Created by Vincent Fazio on 3/25/19.
//  Copyright © 2019 Vincent Fazio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //create four outlets and connect by opening story board and draging the outlets to this spot
    
    private var contacts = [Contact]()
    private var selectedContact: Int?
   
    //link these 4 outlets or remake through what i wrote above
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var PhoneTextField: UITextField!
    @IBOutlet weak var AddressTextField: UITextField!
    @IBOutlet weak var ContactsTableView: UITextView! // add datasource and delegate lined to storyboard
    
    //add the 3 buttons(actions) now save way cry click drag from storyboard, name to what I have written down
    @IBAction func AddButtonClicked(_ sender: UIButton){
        let name = NameTextField.text ?? ""
        let phone = PhoneTextField.text ?? ""
        let address = AddressTextField.text ?? ""
        
            let contact = Contact(id: 0, name: name, phone: phone, address: address)
            contacts.append(contact)
            ContactsTableView.insertRows(at: [NSIndexPath(row: contacts.count-1, section:0) as IndexPath], with: .fade)
        
    }
    
    @IBAction func DeleteButtonClicked(_ sender: UIButton) {
        if selectedContact != nil {
            
                contacts.remove(at: selectedContact!)
                ContactsTable.deleteRows(at: [NSIndexPath(row: selectedContact!, section: 0) as IndexPath], with: .fade)
        } else {
            print("No Items selected")
        }
    }
    
    @IBAction func UpdateButtonClicked(_ sender: UIButton) {
        if selectedContact != nil {
            let id = contacts[selectedContact!].id!
            let contact = Contact(
                id: id,
                name: NameTextField.text ?? "",
                phone: PhoneTextField.text ?? "",
                address: AddressTextField.text ?? "")
            
                contacts.remove(at: selectedContact!)
                contacts.insert(contact, at: selectedContact!)
            
            ContactsTableView.reloadData()
        } else {
            print("No item selected")
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell")!
        var label: UILabel
                        //change name to tag 1
        label = cell.viewWithTag(1) as! UILabel
        label.text = contacts[indexPath.row].name
                        //change to tag 2
        label = cell.viewWithTag(2) as! UILabel
        label.text = contacts[indexPath.row].phone
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NameTextField.text = contacts[indexPath.row].name
        PhoneTextField.text = contacts[indexPath.row].phone
        AddressTextField.text = contacts[indexPath.row].address
        
        selectedContact = indexPath.row
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ContactsTableView.delegate = self
        ContactsTableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

