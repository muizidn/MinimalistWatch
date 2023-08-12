//
//  NumberButton.swift
//  Minimalist Watch
//
//  Created by Muhammad Muizzsuddin on 13/08/23.
//

import SwiftUI

struct NumberButton: View {
    let number: Int
    @EnvironmentObject var vm: CountdownTimerViewModel
    
    var body: some View {
        Button(action: {
            vm.addCustomTimer(number: number)
        }, label: {
            Text("\(number)")
                .font(.title)
                .padding()
        })
    }
}

extension Array: Identifiable where Element: Identifiable {
    public var id: String { map({ "\($0.id)"}).joined() }
}
