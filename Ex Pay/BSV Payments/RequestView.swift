//
//  RequestView.swift
//  BSV Payments
//
//  Created by Jack Knight on 21/06/2021.
//

import SwiftUI
import Contacts


struct RequestView: View {
    
    @State private var contacts = [ContactInfo.init(firstName: "", lastName: "", phoneNumber: nil)]
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    
    func getContacts() {
            DispatchQueue.main.async {
                self.contacts = FetchContacts().fetchingContacts()
            }
        }



    func requestAccess() {
            let store = CNContactStore()
            switch CNContactStore.authorizationStatus(for: .contacts) {
            case .authorized:
                self.getContacts()
            case .denied:
                store.requestAccess(for: .contacts) { granted, error in
                    if granted {
                        self.getContacts()
                    }
                }
            case .restricted, .notDetermined:
                store.requestAccess(for: .contacts) { granted, error in
                    if granted {
                        self.getContacts()
                    }
                }
           @unknown default:
                print("error")
            }
        }
    
    var body: some View {
        
        NavigationView {
            VStack{
                // Search view
                      HStack {
                        HStack {
                           //search bar magnifying glass image
                           Image(systemName: "magnifyingglass").foregroundColor(.secondary)
                                    
                           //search bar text field
                           TextField("search", text: self.$searchText, onEditingChanged: { isEditing in
                           self.showCancelButton = true
                           })
                           
                           // x Button
                           Button(action: {
                               self.searchText = ""
                           }) {
                               Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.secondary)
                                      .opacity(self.searchText == "" ? 0 : 1)
                              }
                    }
                     .padding(8)
                     .background(Color(.secondarySystemBackground))
                     .cornerRadius(8)
                                
                      // Cancel Button
                      if self.showCancelButton  {
                          Button("Cancel") {
                             UIApplication.shared.endEditing(true)
                             self.searchText = ""
                             self.showCancelButton = false
                       }
                     }
                   }
                    .padding([.leading, .trailing,.top])
                
           //      Contact List
                            List {
                                ForEach (self.contacts.filter({ (cont) -> Bool in
                                    self.searchText.isEmpty ? true :
                                        "\(cont)".lowercased().contains(self.searchText.lowercased())
                                })) { contact in
                                    //ContactRow(contact: contact)
                                    NavigationLink(
                                        destination: ContactPhoneNumber(contact: contact),
                                        label: {
                                            ContactRow(contact: contact)
                                        })
                                }
                            }.onAppear() {
                                self.requestAccess()
                            }
                
                
            }.navigationBarTitle("Request")
        }
     //above is end of the VStack
    }
    
    // contacts try
    class FetchContacts {
        
        func fetchingContacts() -> [ContactInfo]{
            var contacts = [ContactInfo]()
            let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
            let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
            do {
                try CNContactStore().enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                    contacts.append(ContactInfo(firstName: contact.givenName, lastName: contact.familyName, phoneNumber: contact.phoneNumbers.first?.value))
                })
            } catch let error {
                print("Failed", error)
            }
            contacts = contacts.sorted {
                $0.firstName < $1.firstName
            }
            return contacts
        }
    }
    
    
    
    }
// the end of the view container
extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}






struct ContactInfo : Identifiable{
    var id = UUID()
    var firstName: String
    var lastName: String
    var phoneNumber: CNPhoneNumber?
}

struct ContactRow: View {
    var contact: ContactInfo
    var body: some View {
        Text("\(contact.firstName) \(contact.lastName)").foregroundColor(.primary)
    }
}

struct ContactPhoneNumber: View {
    var contact: ContactInfo
    var body: some View {
        Text("\(contact.phoneNumber!) ").foregroundColor(.primary)
    }
}

struct RequestView_Previews: PreviewProvider {
    static var previews: some View {
        RequestView()
    }
}
