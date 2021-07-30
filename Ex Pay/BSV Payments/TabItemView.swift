//
//  TabItemView.swift
//  BSV Payments
//
//  Created by Jack Knight on 20/06/2021.
//

import SwiftUI

struct TabItemView: View {
    var iconImage: String
    var iconLabel: String
    var body: some View {
        VStack{
            Image(systemName:iconImage )
            Text(iconLabel)
                .font(.footnote)
        }
    }
}

struct TabItemView_Previews: PreviewProvider {
    static var previews: some View {
        TabItemView(iconImage: "house", iconLabel: "Home" )
    }
}
