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
    var firstNames: [String] = [String]()
    var lastNames: [String] = [String]()
    var phones: [String] = [String]()
    var emails: [String] = [String]()
    @IBOutlet weak var greenV: UIView!
    var i = 0
    var j = 0
    var allowedNext = true
    var currentColor = 0
    let blueColor = UIColor(rgb: 0x008dd5)
    let orangeColor = UIColor(rgb: 0xf06449)
    let greenColor = UIColor(rgb: 0x34435e)
    var soFar = 0;
    var divisionParam: CGFloat!
    var currentAngleFake = 0.0
    var currentAngleMain = 0.0
    var mainSwipe: UIView!
    var fakeSwipe: UIView!
    var miniPhoneReal: UILabel!
    var miniPhoneFake: UILabel!
    var fullNameLblFake: UILabel!
    var swipes = 0
    var panGesture  = UIPanGestureRecognizer()
    var firstNameLblContainerFake: UIView!
    var firstNameLblContainer: UIView!
    var realCircleView: UIView!
    var PhoneFake: UILabel!
    var EmailFake: UILabel!
    var miniEmailFake: UILabel!
    var PhoneReal: UILabel!
    var miniEmailReal: UILabel!
    var EmailReal: UILabel!
    var fullNameLbl: UILabel!
    var lastColor: UIColor!
    var letterLblMain: UILabel!
    var letterLblFake: UILabel!
    var fakeCircleView: UIView!
     //let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.panGesture))
    override func viewDidLoad() {
        super.viewDidLoad()
        divisionParam = (view.frame.size.width/2)/0.61
        
       
      
         generateViews()
          addFakeView()
        fetchContacts()
        lastColor = blueColor
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureValueChanged))
        mainSwipe.addGestureRecognizer(panGesture)
        
      //  self.mainSwipe.addGestureRecognizer(panGesture)
    }
    func generateViews() {

            mainSwipe = UIView(frame: CGRect(x: view.frame.width/2, y: view.frame.height/2, width: view.frame.width * 0.9, height: view.frame.height*0.4))
            mainSwipe.backgroundColor=blueColor
            mainSwipe.layer.cornerRadius=10
            mainSwipe.isUserInteractionEnabled = true
            mainSwipe.center = self.view.center
            mainSwipe.backgroundColor = blueColor
        
            mainSwipe.shadow = false
        
            realCircleView = UIView(frame: CGRect(x: 12, y: 12, width: mainSwipe.frame.width * 0.27, height: mainSwipe.frame.width*0.27))
            realCircleView.backgroundColor = UIColor.black
            realCircleView.alpha = 0.5
            realCircleView.layer.cornerRadius = realCircleView.frame.size.width / 2
            self.mainSwipe.addSubview(realCircleView)
            letterLblMain = UILabel(frame: CGRect(x: realCircleView.center.x/4,y:realCircleView.center.y/4, width: realCircleView.frame.width*0.7, height: realCircleView.frame.height*0.7))
            realCircleView.addSubview(letterLblMain)
            letterLblMain.textColor = UIColor.white
            letterLblMain.text = ""
            letterLblMain.font = UIFont(name: "Montserrat", size: 80)
            letterLblMain.numberOfLines = 1
            letterLblMain.minimumScaleFactor = 0.01
            letterLblMain.adjustsFontSizeToFitWidth = true
            letterLblMain.textAlignment = .center
            letterLblMain.baselineAdjustment = .alignCenters
            firstNameLblContainer = UIView(frame: CGRect(x: realCircleView.frame.width + 24, y: 12, width: mainSwipe.frame.width * 0.6, height: realCircleView.frame.height))
            self.mainSwipe.addSubview(firstNameLblContainer)
            fullNameLbl = UILabel(frame: CGRect(x: 0,y:0, width: firstNameLblContainer.frame.width, height: firstNameLblContainer.frame.height))
            firstNameLblContainer.addSubview(fullNameLbl)
            fullNameLbl.textColor = UIColor.white
            fullNameLbl.text = "Swipe\nTo Begin!"
            fullNameLbl.font = UIFont(name: "Montserrat", size: 80)
            fullNameLbl.numberOfLines = 2
            fullNameLbl.minimumScaleFactor = 0.01
            fullNameLbl.adjustsFontSizeToFitWidth = true
            miniPhoneReal = UILabel(frame: CGRect(x: 12,y:24+realCircleView.frame.height, width: realCircleView.frame.width, height: firstNameLblContainer.frame.height/4))
            mainSwipe.addSubview(miniPhoneReal)
            miniPhoneReal.textColor = UIColor.white
            miniPhoneReal.text = "To Delete"
            miniPhoneReal.font = UIFont(name: "Montserrat-Medium", size: 80)
            miniPhoneReal.numberOfLines = 0
            miniPhoneReal.minimumScaleFactor = 0.01
            miniPhoneReal.adjustsFontSizeToFitWidth = true
            PhoneReal = UILabel(frame: CGRect(x: 12,y:18+realCircleView.frame.height+miniPhoneReal.frame.height, width: mainSwipe.frame.width*0.9, height: firstNameLblContainer.frame.height/2))
            mainSwipe.addSubview(PhoneReal)
            PhoneReal.textColor = UIColor.white
            PhoneReal.text = "Swipe Right"
            PhoneReal.font = UIFont(name: "Montserrat", size: 80)
            PhoneReal.numberOfLines = 0
            PhoneReal.minimumScaleFactor = 0.01
            PhoneReal.adjustsFontSizeToFitWidth = true
            miniEmailReal = UILabel(frame: CGRect(x: 12,y:24+realCircleView.frame.height+miniPhoneReal.frame.height+PhoneReal.frame.height, width: realCircleView.frame.width, height: firstNameLblContainer.frame.height/4))
            mainSwipe.addSubview(miniEmailReal)
            miniEmailReal.textColor = UIColor.white
            miniEmailReal.text = "To Keep"
            miniEmailReal.font = UIFont(name: "Montserrat-Medium", size: 80)
            miniEmailReal.numberOfLines = 0
            miniEmailReal.minimumScaleFactor = 0.01
            miniEmailReal.adjustsFontSizeToFitWidth = true
            EmailReal = UILabel(frame: CGRect(x: 12,y:18+realCircleView.frame.height+miniPhoneReal.frame.height+miniPhoneReal.frame.height+PhoneReal.frame.height, width: mainSwipe.frame.width*0.9, height: firstNameLblContainer.frame.height/2))
            mainSwipe.addSubview(EmailReal)
            EmailReal.textColor = UIColor.white
            EmailReal.text = "Swipe Left"
            EmailReal.font = UIFont(name: "Montserrat", size: 80)
            EmailReal.numberOfLines = 0
            EmailReal.minimumScaleFactor = 0.01
            EmailReal.adjustsFontSizeToFitWidth = true
    }
    func addFakeView() {
        fakeSwipe = UIView(frame: CGRect(x: view.frame.width/2, y: view.frame.height/2, width: view.frame.width * 0.9, height: view.frame.height*0.4))
        fakeSwipe.backgroundColor=blueColor
        fakeSwipe.layer.cornerRadius=10
        fakeSwipe.isUserInteractionEnabled = true
        fakeSwipe.center = self.view.center
        self.view.addSubview(fakeSwipe)
        self.view.addSubview(mainSwipe)
        firstNameLblContainerFake = UIView(frame: CGRect(x: realCircleView.frame.width + 24, y: 12, width: mainSwipe.frame.width * 0.6, height: realCircleView.frame.height))
        fakeCircleView = UIView(frame: CGRect(x: 12, y: 12, width: mainSwipe.frame.width * 0.27, height: mainSwipe.frame.width*0.27))
        fakeCircleView.backgroundColor = UIColor.black
        fakeCircleView.layer.cornerRadius = realCircleView.frame.size.width / 2
        fakeCircleView.alpha = 0.5
        letterLblFake = UILabel(frame: CGRect(x: fakeCircleView.center.x/4,y:fakeCircleView.center.y/4, width: fakeCircleView.frame.width*0.7, height: fakeCircleView.frame.height*0.7))
        fakeCircleView.addSubview(letterLblFake)
        letterLblFake.textColor = UIColor.white
        letterLblFake.text = ""
        letterLblFake.font = UIFont(name: "Montserrat", size: 80)
        letterLblFake.numberOfLines = 1
        letterLblFake.minimumScaleFactor = 0.01
        letterLblFake.adjustsFontSizeToFitWidth = true
        letterLblFake.textAlignment = .center
        letterLblFake.baselineAdjustment = .alignCenters
        fakeSwipe.addSubview(fakeCircleView)
        fakeSwipe.addSubview(firstNameLblContainerFake)
        fullNameLblFake = UILabel(frame: CGRect(x: 0,y:0, width: firstNameLblContainer.frame.width, height: firstNameLblContainer.frame.height))
        fullNameLblFake.textColor = UIColor.white
        fullNameLblFake.text = "Loading\nContacts"
        fullNameLblFake.font = UIFont(name: "Montserrat", size: 80)
        fullNameLblFake.numberOfLines = 2
        fullNameLblFake.minimumScaleFactor = 0.01
        fullNameLblFake.adjustsFontSizeToFitWidth = true
        miniPhoneFake = UILabel(frame: CGRect(x: 12,y:24+realCircleView.frame.height, width: realCircleView.frame.width, height: firstNameLblContainer.frame.height/4))
        firstNameLblContainerFake.addSubview(fullNameLblFake)
        fakeSwipe.addSubview(miniPhoneFake)
        miniPhoneFake.textColor = UIColor.white
        miniPhoneFake.text = "PHONE"
        miniPhoneFake.font = UIFont(name: "Montserrat-Medium", size: 80)
        miniPhoneFake.numberOfLines = 0
        miniPhoneFake.minimumScaleFactor = 0.01
        miniPhoneFake.adjustsFontSizeToFitWidth = true
        PhoneFake = UILabel(frame: CGRect(x: 12,y:18+realCircleView.frame.height+miniPhoneReal.frame.height, width: mainSwipe.frame.width*0.9, height: firstNameLblContainer.frame.height/2))
        fakeSwipe.addSubview(PhoneFake)
        PhoneFake.textColor = UIColor.white
        PhoneFake.text = "(402)-517-1715"
        PhoneFake.font = UIFont(name: "Montserrat", size: 80)
        PhoneFake.numberOfLines = 0
        PhoneFake.minimumScaleFactor = 0.01
        PhoneFake.adjustsFontSizeToFitWidth = true
        //Add mini email lbl
        miniEmailFake = UILabel(frame: CGRect(x: 12,y:24+realCircleView.frame.height+miniPhoneReal.frame.height+PhoneFake.frame.height, width: realCircleView.frame.width, height: firstNameLblContainer.frame.height/4))
        fakeSwipe.addSubview(miniEmailFake)
        miniEmailFake.textColor = UIColor.white
        miniEmailFake.text = "EMAIL"
        miniEmailFake.font = UIFont(name: "Montserrat-Medium", size: 80)
        miniEmailFake.numberOfLines = 0
        miniEmailFake.minimumScaleFactor = 0.01
        miniEmailFake.adjustsFontSizeToFitWidth = true
        EmailFake = UILabel(frame: CGRect(x: 12,y:18+realCircleView.frame.height+miniPhoneReal.frame.height+miniPhoneReal.frame.height+PhoneFake.frame.height, width: mainSwipe.frame.width*0.9, height: firstNameLblContainer.frame.height/2))
        fakeSwipe.addSubview(EmailFake)
        EmailFake.textColor = UIColor.white
        EmailFake.text = "No email"
        EmailFake.font = UIFont(name: "Montserrat", size: 80)
        EmailFake.numberOfLines = 0
        EmailFake.minimumScaleFactor = 0.01
        EmailFake.adjustsFontSizeToFitWidth = true
         fakeSwipe.shadow = true
    }
   
    let store = CNContactStore()
    @objc func panGestureValueChanged(sender: UIPanGestureRecognizer) {
        let cardView = sender.view!
        let translationPoint = sender.translation(in: view)
        cardView.center = CGPoint(x: view.center.x+translationPoint.x, y: view.center.y)
        
        let distanceMoved = cardView.center.x - view.center.x
        if distanceMoved > 0 { // moved right side
           // fakeSwipe.alpha = abs(distanceMoved)/view.center.x
            mainSwipe.alpha = (1.0 - ((abs(distanceMoved)/view.center.x)/2))
            redV.alpha = abs(distanceMoved)/view.center.x
            
            
        }
        else { // moved left side
            mainSwipe.alpha = (1.0 - ((abs(distanceMoved)/view.center.x)/2))
            greenV.alpha = abs(distanceMoved)/view.center.x
            //fakeSwipe.alpha = abs(distanceMoved)/view.center.x

        }
        cardView.transform = CGAffineTransform(rotationAngle: distanceMoved/divisionParam)
        if sender.state == UIGestureRecognizer.State.ended {
            if cardView.center.x < 20 { // Moved to left
                
                UIView.animate(withDuration: 0.3, animations: {
                    cardView.center = CGPoint(x: cardView.center.x-200, y: cardView.center.y)
                }, completion: { _ in
                    
                    self.resetCardViewToOriginalPosition()
                    self.mainSwipe.alpha = 0.0
                    self.nextCardUpdate()
                })
                return
            }
            else if (cardView.center.x > (view.frame.size.width-20)) { // Moved to right
                UIView.animate(withDuration: 0.3, animations: {
                    cardView.center = CGPoint(x: cardView.center.x+200, y: cardView.center.y)
                }, completion: { _ in
                   
                    self.resetCardViewToOriginalPosition()
                     self.mainSwipe.alpha = 0.0
                    self.mainDeleteT()
                    
                })
                return
            }
            UIView.animate(withDuration: 0.2, animations: {
                self.resetCardViewToOriginalPosition()
            })
            UIView.animate(withDuration: 0.3, animations: {
                self.redV.alpha = 0
                self.greenV.alpha = 0
            })
            
        }
    }
    
    func resetCardViewToOriginalPosition(){
        mainSwipe.center = self.view.center
        self.mainSwipe.alpha = 1
       // self.fakeSwipe.alpha = 0.0
  
        mainSwipe.transform = .identity
        
    }
    
    
    func fetchContacts() {
        i = 0
        firstNames = [""]
        lastNames = [""]
        phones = [""]
        print("Attempting to fetch contacts")
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
                    _ = 0
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointerIfYouWantToStopEnumerating) in
                        
                        self.phones.append(contact.phoneNumbers.first?.value.stringValue ?? "(No Phone Found)")
                        self.firstNames.append(contact.givenName)
                        self.lastNames.append(contact.familyName)
                        //self.emails.append(contact.emailAddresses[0] as! String)
                    })
                   
                    self.phones.append("You have no more to delete")
                    self.firstNames.append("All")
                    self.lastNames.append("Done!")
                    DispatchQueue.main.async {

                    if(self.lastNames[self.j+1] == ""){
                        self.fullNameLblFake.text = "\(self.firstNames[self.j+1])"
                    }
                    else {
                        self.fullNameLblFake.text = "\(self.firstNames[self.j+1])\n\(self.lastNames[self.j+1])"
                    }
                    self.PhoneFake.text = self.phones[self.j+1]
                    }
                    self.nextCardUpdate()
                } catch let err {
                    print("Failed to enumerate contacts:", err)
                }
                
            } else {
                print("Access denied..")
            }
        }
       
    
        
        
    }
    
    @IBAction func keepAction(_ sender: Any) {
        self.nextCardUpdate()
    }
    @IBAction func deleteAction(_ sender: Any) {
        
        self.mainDeleteT()
        angleViews()
        UIView.animate(withDuration: 0.3, animations: {
            self.mainSwipe.center = CGPoint(x: self.mainSwipe.center.x-200, y: self.mainSwipe.center.y)
        }
        )
    }
    
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
                _ = UIImage(data: contact.imageData!)
                // Do what ever you want with the contact image below
               // imageTest.image = image
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
                self.nextCardUpdate()
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
                self.nextCardUpdate()
                
            } catch let e{
                print("Error = \(e)")
            }
        } catch let err{
            print(err)
        }
    }
    
    
    func angleViews() {
        UIView.animate(withDuration: 0.7, animations: {
            self.redV.alpha = 0
            self.greenV.alpha = 0
        })
        print("Swipes: ", swipes)
        print(swipes%2)
        
        if(swipes % 2 == 0) {
            fakeSwipe.transform = mainSwipe.transform.rotated(by: CGFloat(currentAngleFake * .pi / 180))
            mainSwipe.transform = mainSwipe.transform.rotated(by: CGFloat(currentAngleMain * .pi / 180))
        }
        else {
            fakeSwipe.transform = mainSwipe.transform.rotated(by: CGFloat(currentAngleMain * .pi / 180))
            mainSwipe.transform = mainSwipe.transform.rotated(by: CGFloat(currentAngleFake * .pi / 180))
        }
    }
    @IBOutlet weak var redV: UIView!
    func mainDeleteT() {
        if(allowedNext) {
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
                
                self.nextCardUpdate()
                
            } catch let e
            {
                print("Error = \(e)")
            }
        } catch let err{
            print(err)
        }
        }
    }
 
    func nextCardUpdate() {
       
        //mainSwipe.alpha = 0.0
         DispatchQueue.main.async {
        let colors = ["red", "green", "pink", "blue"] // stored as String
        
            self.mainSwipe.backgroundColor = self.lastColor
            self.lastColor = UIColor.fromString(name: colors.randomElement())
            self.fakeSwipe.backgroundColor = self.lastColor
       
    print("Next Card Update()")
            
            self.swipes = self.swipes+1
            self.angleViews()
            self.miniEmailFake.text = "EMAIL"
            self.miniEmailReal.text = "EMAIL"
            self.miniPhoneFake.text = "PHONE"
            self.miniPhoneReal.text = "PHONE"
            self.EmailReal.text = "No Email"
            self.EmailFake.text = "No Email"
           
        if(self.j < self.firstNames.count) {
                if(self.lastNames[self.j] == ""){
                    self.fullNameLbl.text = "\(self.firstNames[self.j])"
                }
                else {
                    self.fullNameLbl.text = "\(self.firstNames[self.j])\n\(self.lastNames[self.j])"
                }
            self.PhoneReal.text = self.phones[self.j]
                if(self.allowedNext) {
                    if(self.lastNames[self.j+1] == ""){
                        self.fullNameLblFake.text = "\(self.firstNames[self.j+1])"
                    }
                    else {
                        self.fullNameLblFake.text = "\(self.firstNames[self.j+1])\n\(self.lastNames[self.j+1])"
                }
            self.letterLblMain.text = "\(self.firstNames[self.j].prefix(1))\(self.lastNames[self.j].prefix(1))"
            
            self.letterLblFake.text = "\(self.firstNames[self.j+1].prefix(1))\(self.lastNames[self.j+1].prefix(1))"
            self.PhoneFake.text = self.phones[self.j+1]
            if(self.firstNames[self.j+1] == "" && self.lastNames[self.j+1 ] == "" && (self.phones[self.j+1] == "(No Phone Found)" || self.phones[self.j+1] == "")) {
                self.j = self.j+1;
                if(self.lastNames[self.j+1] == ""){
                    self.fullNameLblFake.text = "\(self.firstNames[self.j+1])"
                }
                else {
                    self.fullNameLblFake.text = "\(self.firstNames[self.j+1])\n\(self.lastNames[self.j+1])"
                }
                self.letterLblFake.text = "\(self.firstNames[self.j+1].prefix(1))\(self.lastNames[self.j+1].prefix(1))"
                self.PhoneFake.text = self.phones[self.j+1]
            }
            if(self.EmailFake.text == "No Email") {
                self.EmailFake.alpha = 0.5
                self.miniEmailFake.alpha = 0.5
            }
            if(self.EmailReal.text == "No Email") {
                self.EmailReal.alpha = 0.5
                self.miniEmailReal.alpha = 0.5
            }
            if(self.PhoneFake.text == "(No Phone Found)") {
                self.PhoneFake.alpha = 0.5
                self.miniPhoneFake.alpha = 0.5
            }
            else {
                self.PhoneFake.alpha = 1.0
                self.miniPhoneFake.alpha = 1.0
                
            }
            if(self.PhoneReal.text == "(No Phone Found)") {
                self.PhoneReal.alpha = 0.5
                self.miniPhoneReal.alpha = 0.5
            }
            else {
                self.PhoneReal.alpha = 1.0
                self.miniPhoneReal.alpha = 1.0
                
            }
            self.j = self.j+1;
            self.mainSwipe.alpha = 1.0
            if(self.PhoneFake.text == "You have no more to delete") {
                self.allowedNext = false
            }
        }
            
        }
    }
    }
        
}
