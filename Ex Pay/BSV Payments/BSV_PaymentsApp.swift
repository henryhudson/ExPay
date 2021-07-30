//
//  BSV_PaymentsApp.swift
//  BSV Payments
//
//  Created by Jack Knight on 16/06/2021.
//

import SwiftUI

@main
struct BSV_PaymentsApp: App {
    var body: some Scene {
        WindowGroup { TabView{
            ContentView().tag(0)
                .tabItem{
                    TabItemView(iconImage: "house" , iconLabel: "Home")
                    
                }
            
           SendView()
              .tag(1)
              .tabItem {
                TabItemView(iconImage: "paperplane",
                            iconLabel: "Send")
              }
            
            RequestView()
               .tag(2)
               .tabItem {
                 TabItemView(iconImage: "plus",
                             iconLabel: "Request")
               }
            
            HelpView()
               .tag(3)
               .tabItem {
                 TabItemView(iconImage: "questionmark.circle",
                             iconLabel: "Help")
               }
            
        }
        }
    }
}


