//
//  Example_State.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 24/6/26.
//

import SwiftUI

struct ControlButtonsView: View {
     @Binding var count: Int

    var body: some View {
        HStack(spacing: 20) {
            Button(action: {
                count -= 1
            }) {
                Image(systemName: "minus.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.red)
            }

            Button(action: {
                count += 1
            }) {
                Image(systemName: "plus.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.green)
            }
        }
    }
}

struct ExampleStateView: View {
    @State private var currentCount: Int = 20

    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 8) {
                Text("Counter")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                    .bold()

                Text("Current number:")
                    .font(.headline)

                Text("\(currentCount)")
                    .font(.system(size: 60, weight: .bold, design: .rounded))
            }
            ControlButtonsView(count: $currentCount)
        }
        .padding()
    }
}

struct ExampleStateView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleStateView()
    }
}
