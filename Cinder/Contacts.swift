//
//  Contacts.swift
//  Cinder
//
//  Created by Clayton Loneman on 12/6/18.
//  Copyright © 2018 Clayton Loneman. All rights reserved.
//  Code copied/edited from GSK @ https://stackoverflow.com/questions/33973574/fetching-all-contacts-in-ios-swift
//

import Foundation
import ContactsUI

class PhoneContacts {
    enum ContactsFilter {
        case none
        case mail
        case message
    }
    class func getContacts(filter: ContactsFilter = .none) -> [CNContact] { //  ContactsFilter is Enum find it below
        
        let contactStore = CNContactStore()
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey,
            CNContactThumbnailImageDataKey] as [Any]
        
        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containers(matching: nil)
        } catch {
            print("Error fetching containers")
        }
        
        var results: [CNContact] = []
        
        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
            
            do {
                let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
                results.append(contentsOf: containerResults)
            } catch {
             print("Error fetching containers")
            }
        }
        return results
}
}


class PhoneContact: NSObject {
    
    var name: String?
    var avatarData: Data?
    var phoneNumber: [String] = [String]()
    var email: [String] = [String]()
    var isSelected: Bool = false
    var isInvited = false
    
    init(contact: CNContact) {
        name        = contact.givenName + " " + contact.familyName
        avatarData  = contact.thumbnailImageData
        for phone in contact.phoneNumbers {
            phoneNumber.append(phone.value.stringValue)
        }
        for mail in contact.emailAddresses {
            email.append(mail.value as String)
        }
    }
    
    override init() {
        super.init()
    }
}
