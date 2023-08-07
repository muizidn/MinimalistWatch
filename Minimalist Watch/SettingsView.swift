//
//  SettingsView.swift
//  Minimalist Watch
//
//  Created by Muhammad Muizzsuddin on 02/08/23.
//

import SwiftUI

struct SettingsView: View {
    let items = (1...20).map { $0.description }
    
    let columns: [GridItem] = [
        GridItem(.fixed(100), spacing: 8),
    ]
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(items, id: \.self) { image in
                    Color.red
                }
            }
            
            HStack {
                Text("Time")
                Toggle("24H", isOn: .constant(false))
                    .toggleStyle(SwitchToggleStyle())
            }
            
            HStack {
                Text("Show Date")
                Toggle("", isOn: .constant(false))
                    .toggleStyle(SwitchToggleStyle())
            }
        }
        .padding()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
