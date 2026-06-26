//
//  ExampleList+NavigationSwiftUI.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 25/6/26.
//

import SwiftUI

struct Article: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let content: String
}

struct ArticleDetailView: View {
    let article: Article

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(article.title)
                .font(.title)
                .bold()

            Text(article.content)
                .font(.body)

            Spacer()
        }
        .padding()
        .navigationTitle("Article Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ExampleListView: View {
    let articles = [
        Article(title: "Learning SwiftUI", content: "SwiftUI easy to learn if you strong understand State and Binding..."),
        Article(title: "Say bye UIKit?", content: "UIKit still very important, but you need to merge both of them is now trending..."),
        Article(title: "What is MVVM pattern?", content: "MVVM helps spliting UI(View) into bussiness logic(ViewModel)...")
    ]

    var body: some View {
        List(articles) { article in
            NavigationLink(value: article) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(article.title)
                        .font(.headline)
                    Text(article.content)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
            }
        }
        .navigationTitle("Overview")
        .navigationDestination(for: Article.self) { selectedArticle in
            ArticleDetailView(article: selectedArticle)
        }
    }
}

struct ExampleListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ExampleListView()
        }
    }
}
