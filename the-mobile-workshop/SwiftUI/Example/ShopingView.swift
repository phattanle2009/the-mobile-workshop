//
//  ShopingView.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 28/6/26.
//

import SwiftUI
import Combine

struct Product: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let price: String
}

class CartViewModel: ObservableObject {
    @Published var itemsCount: Int = 0

    func addToCart() {
        itemsCount += 1
    }

    func clearCart() {
        itemsCount = 0
    }
}

struct MainShopView: View {
    @StateObject var cartVM = CartViewModel()
    @State private var path = NavigationPath()

    let products: [Product] = (1...100).map { Product(name: "iPhone đời thứ \($0)", price: "\($0 * 10) triệu") }

    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    ForEach(products) { product in
                        NavigationLink(value: product) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(product.name).font(.headline)
                                    Text(product.price).foregroundColor(.gray)
                                }
                                Spacer()
                                Image(systemName: "chevron.right").foregroundColor(.secondary)
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(8)
                            .shadow(radius: 1)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .navigationTitle("Shop Công Nghệ")
            .background(Color(.systemGroupedBackground))
            .navigationDestination(for: Product.self) { product in
                ProductDetailView(product: product)
            }
            .navigationDestination(for: String.self) { destination in
                if destination == "CartView" {
                    CartView(path: $path)
                }
            }
            .toolbar {
                Button(action: {
                    path.append("CartView")
                }) {
                    HStack {
                        Image(systemName: "cart.fill")
                        Text("\(cartVM.itemsCount)")
                    }
                }
            }
        }
        .environmentObject(cartVM)
    }
}

struct ProductDetailView: View {
    let product: Product

    @EnvironmentObject var cartVM: CartViewModel

    var body: some View {
        VStack(spacing: 24) {
            Text(product.name).font(.largeTitle).bold()
            Text("Giá bán: \(product.price)").font(.title2).foregroundColor(.red)

            Button(action: {
                cartVM.addToCart()
            }) {
                Text("Thêm vào giỏ hàng")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Chi tiết")
    }
}

struct CartView: View {
    @Binding var path: NavigationPath
    @EnvironmentObject var cartVM: CartViewModel

    var body: some View {
        VStack(spacing: 30) {
            Text("Giỏ hàng của ní").font(.title).bold()

            Text("Số lượng món đồ: \(cartVM.itemsCount)")
                .font(.title2)

            Button(action: {
                cartVM.clearCart()
                path = NavigationPath()
            }) {
                Text("Hoàn tất thanh toán & Về trang chủ")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(12)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Giỏ hàng")
    }
}

struct MainShopView_Previews: PreviewProvider {
    static var previews: some View {
        MainShopView()
    }
}
