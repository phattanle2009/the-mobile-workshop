//
//  MySwiftUIView.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 24/6/26.
//

import SwiftUI
import UIKit

struct MySwiftUIView: View {
    @State private var isDarkMode: Bool = false
    @State private var counter: Int = 0

    var body: some View {
        ZStack {
            Color(isDarkMode ? .black : .systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Image(systemName: isDarkMode ? "moon.stars.fill" : "sun.max.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(isDarkMode ? .yellow : .orange)
                    .padding(.top, 40)

                VStack(spacing: 8) {
                    Text("Hi! 👋")
                        .font(.title)
                        .bold()
                        .foregroundColor(isDarkMode ? .white : .black)

                    Text("This screen is written in SwiftUI and is being embedded directly into your UIKit project.")
                        .font(.body)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }

                HStack(spacing: 16) {
                    Text("Counter:")
                        .font(.headline)
                        .foregroundColor(isDarkMode ? .white : .black)

                    Text("\(counter)")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.blue)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                }
                .padding()
                .background(isDarkMode ? Color(white: 0.15) : Color.white)
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)

                Spacer()

                VStack(spacing: 12) {
                    Button(action: {
                        counter += 1
                    }) {
                        Text("Hit to increase")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.blue)
                            .cornerRadius(12)
                    }

                    Button(action: {
                        withAnimation {
                            isDarkMode.toggle()
                        }
                    }) {
                        Text(isDarkMode ? "Switch to Light Mode" : "Switch to Dark Mode")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(.blue)
                    }
                    .padding(.top, 8)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 20)
            }
        }
    }
}

extension MySwiftUIView: ExploreRoutable {
    static let route = "MySwiftUIView"

    static func makeViewController() -> UIViewController {
        let viewController = UIHostingController(rootView: MySwiftUIView())
        viewController.title = "SwiftUI"
        return viewController
    }
}

struct MySwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MySwiftUIView()
    }
}
