//
//  ContentView.swift
//  BSV Payments
//
//  Created by Jack Knight on 16/06/2021.
//

import SwiftUI
 

struct ContentView: View {
    // Retrieving the BSV price
    @State var networking = Networking()

    var whatsOnChainURL: URL = URL(string: "https://api.whatsonchain.com/v1/bsv/main/exchangerate")!
    @State var bitcoinPrice = "0"
    

    //Formatting the BSV price
    let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "GBP"
        return formatter
      }()
    
    var formattedBitcoinPrice: String {
        
        guard let price = Double(bitcoinPrice) else {
          return "failed to get value"
        }
        return currencyFormatter.string(from: NSNumber(value: price))!
      }
    
    
    // bottom sheet state
    
    @State private var showSheet = false
    @State private var displaySheet = false

    var body: some View {
     
        NavigationView{
            
            
            VStack(alignment: .center) {
                
                HStack {
                    Image(systemName: "bitcoinsign.circle")
                    Text("BSV Price")
                    Text("\(formattedBitcoinPrice)")
                        .font(.subheadline)
                    
                    
                    
                    Button(action: {
                        fetchLatestBSVPrice()
                    }, label: {
                        Text("Refresh")
                            .foregroundColor(.white)
                            .frame(width: 100, height: 50, alignment: .center)
                            .background(Color.yellow)
                    })
                }.padding()
                
                
                
                HStack{
                    Text("Balance").font(.title)
                    Image(systemName: "bitcoinsign.circle")
                    Text("0").font(.title)
                }
                
                //resizing using a geometry reader
                
                
                    GeometryReader { geo in
                        
                        Image("Wallet 2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geo.size.width, height: 300)
                            
                        
                    }
                    
                    Button("Show Transactions"){
                        
                        self.showSheet.toggle()
                    }
                    .padding()
                    
                    .background(Color.yellow)
                    .foregroundColor(.white)
                    .padding(.bottom, 50)
                    .sheet(isPresented: $showSheet) {
                        CardContent()
                        
                    }
                
                
                
                
                
                
                
            }.navigationBarTitle("Ex Pay")
            .navigationBarItems(trailing:NavigationLink(destination: ProfileContent()) {
                Image(systemName: "person.crop.circle")
                
                
            })
            
            .onAppear {
                fetchLatestBSVPrice()
                
            }
            
            
            
        }
        
    
    }
    
    func fetchLatestBSVPrice() {
      networking.fetch(whatsOnChainURL, defaultValue: LatestBSVPriceModel.default) {
        bitcoinPrice = $0.rate
      }
    }
        
        }

//bottom sheet card
 struct CardContent: View {
     @Environment(\.presentationMode) var presentationMode
     var body: some View{
        NavigationView{
            
            List{
                    HStack{
                        VStack(alignment: .leading){
                            Text("Jack Knight")
                                .font(.headline)
                                
                            
                    
                        }
                        
                        Spacer()
                        Text("+ £60")
                            .foregroundColor(.green)
                        
                        
                        
                    }
                   
                //copy for UI sake
                HStack{
                    VStack(alignment: .leading){
                        Text("Satoshi Nakamoto")
                            .font(.headline)
                        
                
                    }
                    
                    Spacer()
                    Text("£1000")
                        .foregroundColor(.red)
                    
                    
                    
                }
            
              
            }.navigationBarTitle("Transactions")
            
            
        }
         Button("Dismiss"){
             self.presentationMode.wrappedValue.dismiss()
             
         }
         .padding()
         .background(Color.yellow)
         .foregroundColor(.white)
        
         
     }
 }

// Top profile
struct ProfileContent: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View{
        Form{
            Section(header: Text("Transactions")){
                Text("Transaction 1")
                
                
            }
            
            
            
        }
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                
            ContentView()
        }
    }
}


