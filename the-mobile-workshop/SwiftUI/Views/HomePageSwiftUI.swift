//
//  HomePageSwiftUI.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 25/6/26.
//

import SwiftUI

enum SwiftUIScreens: CaseIterable, Hashable, Identifiable {
    case exampleState
    case exampleList
    case mySwiftUIView
    case examplePattern

    var id: Self { self }

    var title: String {
        switch self {
        case .exampleState:
            return "Example State"
        case .exampleList:
            return "Example List"
        case .mySwiftUIView:
            return "My SwiftUI View"
        case .examplePattern:
            return "Example Pattern"
        }
    }

    var description: String {
        switch self {
        case .exampleState:
            return "Learn @State and basic interaction."
        case .exampleList:
            return "Learn List and ForEach."
        case .mySwiftUIView:
            return "Your first SwiftUI screen."
        case .examplePattern:
            return "Learn Pattern: MVVM with SwiftUI"
        }
    }

    @ViewBuilder
    var destination: some View {
        switch self {
        case .exampleState:
            ExampleStateView()
        case .exampleList:
            ExampleListView()
        case .mySwiftUIView:
            MySwiftUIView()
        case .examplePattern:
            ExamplePatternView()
        }
    }
}

struct HomePageSwiftUI: View {

    var body: some View {
        NavigationStack {
            List(SwiftUIScreens.allCases, id: \.self) { screen in
                NavigationLink(value: screen) {
                    VStack(alignment: .leading) {
                        Text(screen.title)
                            .font(.headline)
                            .fontWeight(.bold)
                        Text(screen.description)
                            .fontWeight(.light)
                            .foregroundStyle(.gray)
                    }
                }
            }
            .navigationTitle("Home")
            .navigationDestination(for: SwiftUIScreens.self) { screen in
                screen.destination
            }
        }
    }
}

extension HomePageSwiftUI: ExploreRoutable {
    static let route = "HomePageSwiftUI"

    static func makeViewController() -> UIViewController {
        SwiftUIWorkshopHostingController(rootView: HomePageSwiftUI())
    }
}

struct HomePageSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        HomePageSwiftUI()
    }
}
