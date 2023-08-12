//
//  CustomCountdownTimer.swift
//  Minimalist Watch
//
//  Created by Muhammad Muizzsuddin on 13/08/23.
//

import SwiftUI

struct CustomCountdownTimer: View {
    enum _Button: Identifiable {
        var id: String { description }
        
        case delete
        case done
        case number(Int)
        
        var description: String {
            return "\(self)"
        }
    }
    
    @EnvironmentObject var vm: CountdownTimerViewModel
    let buttons: [[_Button]] = [
        [.number(1), .number(2), .number(3)],
        [.number(4), .number(5), .number(6)],
        [.number(7), .number(8), .number(9)],
        [.done, .number(0), .delete],
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text(
                    vm.customTimerInput[0].description +
                    vm.customTimerInput[1].description
                )
                Text("h")
                Text(
                    vm.customTimerInput[2].description +
                    vm.customTimerInput[3].description
                )
                Text("m")
                Text(
                    vm.customTimerInput[4].description +
                    vm.customTimerInput[5].description
                )
                Text("s")
            }
            .font(.system(size: 50, weight: .heavy))
            .lineLimit(1)
            Spacer().frame(height: 50)
            VStack(spacing: 20) {
                ForEach(buttons) { btns in
                    HStack(spacing: 20) {
                        ForEach(btns) { button in
                            switch button {
                            case .delete:
                                Button("Delete") {
                                    vm.deleteLastInput()
                                }
                            case .done:
                                Button("Done") {
                                    vm.isEditingCustomTimer.toggle()
                                }
                            case let .number(value):
                                NumberButton(number: value)
                            }
                        }
                        .frame(width: 100, height: 50)
                    }
                }
            }
            .padding()
        }
    }
}
