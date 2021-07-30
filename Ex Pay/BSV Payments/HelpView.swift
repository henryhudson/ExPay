//
//  HelpView.swift
//  BSV Payments
//
//  Created by Jack Knight on 21/06/2021.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        NavigationView{
            Form{
                Section(header:Text("Suggested for you")){
                    
                    Link("My Payment hasn't gone through", destination: URL(string: "https://logo-wallet-application.herokuapp.com/payment.html")!)
                    
                    
                    Link("What is Bitcoin Satoshi's Vision?", destination: URL(string: "https://logo-wallet-application.herokuapp.com/satoshi.html")!)
                    
                    
                    Link("Is my money safe?", destination: URL(string: "https://logo-wallet-application.herokuapp.com/safe.html")!)
                    
                    
                    Link("How do I link my contacts?", destination: URL(string: "https://logo-wallet-application.herokuapp.com/contacts.html")!)
                    
                    
                    Link("How do I link to Facebook?", destination: URL(string: "https://logo-wallet-application.herokuapp.com/facebook.html")!)
                    
            }
        
                Section(header:Text("I need help with a payment")){
                    Button("Clickable transaction"){
                        
                        //click on a transaction
                    }
                    
                }
                
                Section(header:Text ("Browse Articles")){
                    Button("See our help catagories"){
                        
                        //enter a URL
                    }
                    
                }
                
                Section(header:Text("Other useful links")){
                    Link("The Bitcoin whitepaper", destination: URL(string: "https://craigwright.net/bitcoin-white-paper.pdf")!)
                    
                    
                    Link("Bitcoin SV Wiki", destination: URL(string: "https://wiki.bitcoinsv.io/index.php/Main_Page")!)
                    
                    
                }
            }.navigationBarTitle("Help Section")
        }
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
