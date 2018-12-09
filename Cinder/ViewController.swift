//
//  ViewController.swift
//  Cinder
//
//  Created by Clayton Loneman on 12/6/18.
//  Copyright © 2018 Clayton Loneman. All rights reserved.
//

import UIKit
import ContactsUI
import Contacts

class ViewController: UIViewController {
    var firstNames = [""]
    var lastNames = [""]
    var phones = [""]
    @IBOutlet weak var fakeFirst: UILabel!
    @IBOutlet weak var fakeLast: UILabel!
    @IBOutlet weak var fakeNumber: UILabel!
    @IBOutlet weak var fakeBig: UILabel!
    @IBOutlet weak var realBig: UILabel!
    var i = 0
    var j = 0
    var currentColor = 0
    let blueColor = UIColor(rgb: 0x008dd5)
    let orangeColor = UIColor(rgb: 0xf06449)
    let greenColor = UIColor(rgb: 0x34435e)
    var total = 0;
    var soFar = 0;
    var totalDeleted = 0;
    var divisionParam: CGFloat!
    var currentAngleFake = 5.0
    var currentAngleMain = -5.0
    override func viewDidLoad() {
        super.viewDidLoad()
        divisionParam = (view.frame.size.width/2)/0.61
        fetchContacts()
        mainSwipe.backgroundColor = blueColor
        fakeView.backgroundColor = blueColor
        fakeNumber.textColor = UIColor.white
        fakeFirst.textColor = UIColor.white
        fakeLast.textColor = UIColor.white
        phoneLbl.textColor = UIColor.white
        firstNameLbl.textColor = UIColor.white
        lastNameLbl.textColor = UIColor.white
        angleViews()
        fakeBig.alpha = 0.0
        realBig.alpha = 0.0
        fakeCircleView.layer.borderWidth = 1.0
        fakeCircleView.layer.masksToBounds = false
        fakeCircleView.layer.borderColor = UIColor.white.cgColor
       fakeCircleView.layer.cornerRadius = fakeCircleView.frame.size.width / 2
        fakeCircleView.clipsToBounds = true
        realCircleView.layer.borderWidth = 1.0
        realCircleView.layer.masksToBounds = false
        realCircleView.layer.borderColor = UIColor.white.cgColor
        realCircleView.layer.cornerRadius = fakeCircleView.frame.size.width / 2
        realCircleView.clipsToBounds = true
}
    @IBOutlet weak var fakeView: UIView!
    @IBOutlet weak var mainSwipe: UIView!
    let store = CNContactStore()
   
    func updateTotal() {
        soFar = j-1
        total = firstNames.count
        
    }
    @IBAction func panGestureValueChanged(_ sender: UIPanGestureRecognizer) {
        let cardView = sender.view!
        let translationPoint = sender.translation(in: view)
        cardView.center = CGPoint(x: view.center.x+translationPoint.x, y: view.center.y+translationPoint.y)
        
        let distanceMoved = cardView.center.x - view.center.x
        if distanceMoved > 0 { // moved right side
            if(self.currentColor == 0) {
                
                self.fakeView.backgroundColor = self.blueColor
            }
            else if(self.currentColor == 1) {
                
                self.fakeView.backgroundColor = self.orangeColor
                
                
            }
            else if(self.currentColor == 2) {
                
                self.fakeView.backgroundColor = self.greenColor
            }
            fakeView.alpha = abs(distanceMoved)/view.center.x
             redV.alpha = abs(distanceMoved)/view.center.x
            
            
        }
        else { // moved left side
          fakeView.alpha = abs(distanceMoved)/view.center.x
            greenV.alpha = abs(distanceMoved)/view.center.x
            if(self.currentColor == 0) {
            
               self.fakeView.backgroundColor = self.blueColor
            }
            else if(self.currentColor == 1) {
               
                    self.fakeView.backgroundColor = self.orangeColor
                
                
            }
            else if(self.currentColor == 2) {
                
                 self.fakeView.backgroundColor = self.greenColor
            }
        }
        
        //Tilt your card
        cardView.transform = CGAffineTransform(rotationAngle: distanceMoved/divisionParam)
        
        if sender.state == UIGestureRecognizer.State.ended {
            if cardView.center.x < 20 { // Moved to left
                
                UIView.animate(withDuration: 0.3, animations: {
                    cardView.center = CGPoint(x: cardView.center.x-200, y: cardView.center.y)
                }, completion: { _ in
                   
                    if(self.currentColor == 0) { self.currentColor = self.currentColor + 1
                        self.mainSwipe.backgroundColor = self.blueColor
                    }
                    else if(self.currentColor == 1) {
                         self.currentColor = self.currentColor + 1
                        self.mainSwipe.backgroundColor = self.orangeColor
                        
                    }
                    else if(self.currentColor == 2) {
                        self.currentColor = 0
                        self.mainSwipe.backgroundColor = self.greenColor
                    }
                    
                    self.resetCardViewToOriginalPosition()
                    self.beginDelete()
                })
                return
            }
            else if (cardView.center.x > (view.frame.size.width-20)) { // Moved to right
                UIView.animate(withDuration: 0.3, animations: {
                    cardView.center = CGPoint(x: cardView.center.x+200, y: cardView.center.y)
                }, completion: { _ in
                    self.resetCardViewToOriginalPosition()
                    self.mainDeleteT()
                })
                return
            }
            UIView.animate(withDuration: 0.2, animations: {
    self.resetCardViewToOriginalPosition()
            })
            UIView.animate(withDuration: 0.7, animations: {
                self.redV.alpha = 0
                self.greenV.alpha = 0
            })
            
        }
    }
    @IBOutlet weak var greenV: UIView!
    func resetCardViewToOriginalPosition(){
        mainSwipe.center = self.view.center
        self.fakeView.alpha = 0
        self.fakeView.alpha = 0
       
        mainSwipe.transform = .identity
       
    }


     func fetchContacts() {
         i = 0
         firstNames = [""]
         lastNames = [""]
         phones = [""]
        print("Attempting to fetch contacts today..")
        
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts) { (granted, err) in
            if let err = err {
                print("Failed to request access:", err)
                return
            }
            
            if granted {
                print("Access granted")
                
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                
                do {
                    
                   
                    
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointerIfYouWantToStopEnumerating) in
                        
                        self.phones.append(contact.phoneNumbers.first?.value.stringValue ?? "(No Phone Found)")
                        self.firstNames.append(contact.givenName)
                        self.lastNames.append(contact.familyName)
                        
                        
                        //                        favoritableContacts.append(FavoritableContact(name: contact.givenName + " " + contact.familyName, hasFavorited: false))
                    })
                    while(self.i < self.firstNames.count) {
                        print(self.firstNames[self.i],self.lastNames[self.i],self.phones[self.i])
                        self.i = self.i+1;
                    }
                    
                    
                } catch let err {
                    print("Failed to enumerate contacts:", err)
                }
                
            } else {
                print("Access denied..")
            }
        }
    }
    @IBAction func keepAction(_ sender: Any) {
        self.beginDelete()
         
    }
    @IBOutlet weak var imageTest: UIImageView!
    func loadMainImage() {
        let predicate = CNContact.predicateForContacts(matchingName: "\(firstNames[j-1]) \(lastNames[j-1])")
        
        let toFetch = [CNContactEmailAddressesKey]
        
        do{
            let contacts = try store.unifiedContacts(matching: predicate,keysToFetch: toFetch as [CNKeyDescriptor])
            guard contacts.count > 0 else{
                print("No contacts found with name: \(firstNames[j-1]) \(lastNames[j-1])")
               
                return
            }
            
            guard let contact = contacts.first else{
                
                return
            }
            if contact.imageDataAvailable {
                // there is an image for this contact
                let image = UIImage(data: contact.imageData!)
                // Do what ever you want with the contact image below
                imageTest.image = image
            }
          
            
            
            
        } catch let err{
            print(err)
        }
    }
    func deletePhone() {
        let predicatePhone = CNContact.predicateForContacts(matching: CNPhoneNumber(stringValue: phones[j-1]))
        
        
        let toFetch = [CNContactEmailAddressesKey]
        
        do{
            let contacts = try store.unifiedContacts(matching: predicatePhone,keysToFetch: toFetch as [CNKeyDescriptor])
            guard contacts.count > 0 else{
                print("No contacts found with phone: \(phones[j-1])")
                self.beginDelete()
                return
            }
            
            guard let contact = contacts.first else{
                
                return
            }
            
            let req = CNSaveRequest()
            let mutableContact = contact.mutableCopy() as! CNMutableContact
            req.delete(mutableContact)
            
            do{
                try store.execute(req)
                let impact = UIImpactFeedbackGenerator()
                impact.impactOccurred()
                // Or with a completion block
                
                
                
                print("Success, You deleted the phone:  \(firstNames[j-1]) \(lastNames[j-1]) at \(phones[j-1])")
                self.beginDelete()
                totalDeleted = totalDeleted + 1
            } catch let e{
                print("Error = \(e)")
            }
        } catch let err{
            print(err)
        }
    }
    @IBAction func deleteAction(_ sender: Any) {
        self.mainDeleteT()
         angleViews()
        UIView.animate(withDuration: 0.3, animations: {
            self.mainSwipe.center = CGPoint(x: self.mainSwipe.center.x-200, y: self.mainSwipe.center.y)
        }
        )
        }
    func angleViews() {
        UIView.animate(withDuration: 0.7, animations: {
            self.redV.alpha = 0
            self.greenV.alpha = 0
        })
        print("I: ", j)
        print(j%2)
    
        if(j % 2 == 0) {
         fakeView.transform = mainSwipe.transform.rotated(by: CGFloat(currentAngleFake * M_PI / 180))
         mainSwipe.transform = mainSwipe.transform.rotated(by: CGFloat(currentAngleMain * M_PI / 180))
        }
        else {
            fakeView.transform = mainSwipe.transform.rotated(by: CGFloat(currentAngleMain * M_PI / 180))
            mainSwipe.transform = mainSwipe.transform.rotated(by: CGFloat(currentAngleFake * M_PI / 180))
        }
    }
    @IBOutlet weak var redV: UIView!
    func mainDeleteT() {
       
    let predicate = CNContact.predicateForContacts(matchingName: "\(firstNames[j-1]) \(lastNames[j-1])")
    
    let toFetch = [CNContactEmailAddressesKey]
    
    do{
    let contacts = try store.unifiedContacts(matching: predicate,keysToFetch: toFetch as [CNKeyDescriptor])
    guard contacts.count > 0 else{
    print("No contacts found with name: \(firstNames[j-1]) \(lastNames[j-1])")
    self.deletePhone()
    return
    }
    
    guard let contact = contacts.first else{
    
    return
    }
    
    let req = CNSaveRequest()
    let mutableContact = contact.mutableCopy() as! CNMutableContact
    req.delete(mutableContact)
    
    do{
    try store.execute(req)
    let impact = UIImpactFeedbackGenerator()
    impact.impactOccurred()
    
    print("Success, You deleted the user:  \(firstNames[j-1]) \(lastNames[j-1]) at \(phones[j-1])")
    
    totalDeleted = totalDeleted + 1
    self.beginDelete()
    } catch let e{
    print("Error = \(e)")
    }
    } catch let err{
    print(err)
    }
    }
    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var lastNameLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var realCircleView: UIView!
    @IBOutlet weak var fakeCircleView: UIView!
    func beginDelete() {
         angleViews()
        if(self.j < self.firstNames.count) {
          
            firstNameLbl.text = firstNames[j]
            lastNameLbl.text = lastNames[j]
            phoneLbl.text = phones[j]
            
            fakeFirst.text = firstNames[j+1]
            fakeLast.text = lastNames[j+1]
            fakeNumber.text = phones[j+1]
            if(fakeFirst.text == "" && fakeLast.text == "" && fakeNumber.text == "(No Phone Found)") {
                self.j = self.j+1;
                fakeFirst.text = firstNames[j+1]
                fakeLast.text = lastNames[j+1]
                fakeNumber.text = phones[j+1]
            }
             
            self.j = self.j+1;
        }
    }
}
