//
//  ExamplePatternView.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 25/6/26.
//

import SwiftUI
import Combine

struct User: Identifiable {
    let id = UUID()
    let firstName: String
    let lastName: String
    let email: String
}

class ExamplePatternViewModel: ObservableObject {

    @Published var users: [User] = []
    @Published var isLoading: Bool = false

    func fetchUsers() async {
        await MainActor.run {
            isLoading = true
        }

        try? await Task.sleep(nanoseconds: 1_500_000_000)

        var count = 0
        var mockUsers: [User] = []
        let familyNames: [String] = [
            "Nguyễn", "Trần", "Lê", "Phạm", "Hoàng", "Phan", "Vũ",
            "Võ", "Đặng", "Bùi", "Đỗ", "Hồ", "Ngô", "Đinh", "Phạm"
        ]
        let middleAndGivenNames: [String] = [
            "An", "Anh", "Bình", "Bảo", "Cường", "Chi", "Dũng", "Duy", "Danh", "Đạt",
            "Hà", "Hương", "Hải", "Hùng", "Khánh", "Linh", "Minh", "Mai", "Nam", "Nghĩa",
            "Phong", "Phúc", "Quân", "Quỳnh", "Sơn", "Tâm", "Tuấn", "Tú", "Thảo", "Thành",
            "Vinh", "Vy", "Vũ", "Yến", "Phát", "Tuyết", "Kiệt", "Nhung", "Khôi", "Nhi", "Dung"
        ]

        for ho in familyNames {
            for ten in middleAndGivenNames {
                if count >= 100 { break }
                let emailName = ten.lowercased().folding(options: .diacriticInsensitive, locale: .current)
                let emailHo = ho.lowercased().folding(options: .diacriticInsensitive, locale: .current)

                mockUsers.append(
                    User(firstName: ten, lastName: ho, email: "\(emailName).\(emailHo)\(count)@gmail.com")
                )
                count += 1
            }
        }
        mockUsers.sort { $0.firstName < $1.firstName }

        await MainActor.run {
            self.users = mockUsers
            self.isLoading = false
        }
    }

    func seperatorHeaderSection(users: [User]) -> [String: [User]] {
        return Dictionary(grouping: users) { user in
            String(user.firstName.prefix(1)).uppercased()
        }
    }
}

struct ExamplePatternView: View {
    @ObservedObject var viewModel = ExamplePatternViewModel()

    private var groupedUsers: [String: [User]] {
        viewModel.seperatorHeaderSection(users: viewModel.users)
    }

    private var sectionTitles: [String] {
        groupedUsers.keys.sorted()
    }

    var body: some View {
        content
            .navigationTitle("Staff")
            .task {
                await viewModel.fetchUsers()
            }
    }

    @ViewBuilder
    var content: some View {
        if viewModel.isLoading {
            ProgressView("Loading...")
        } else {
            staffList
        }
    }

    private var staffList: some View {
        List {
            ForEach(sectionTitles, id: \.self) { title in
                Section(header: Text(title).font(.headline).foregroundColor(.blue)) {
                    ForEach(groupedUsers[title] ?? []) { user in
                        StaffRowView(user: user)
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .refreshable {
            try? await Task.sleep(nanoseconds: 1_500_000_000)
            await viewModel.fetchUsers()
        }
    }

    struct StaffRowView: View {
        let user: User

        var body: some View {
            HStack {
                AvatarView(user: user)

                VStack(alignment: .leading) {
                    Text("\(user.firstName) \(user.lastName)")
                        .font(.headline)

                    Text(user.email)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
    }

    struct AvatarView: View {
        let user: User

        private var initials: String {
            user.firstName.prefix(1).uppercased()
            + user.lastName.prefix(1).uppercased()
        }

        var body: some View {
            ZStack {
                Circle()
                    .fill(getAvatarColor(for: initials))
                    .frame(width: 40, height: 40)

                Text(initials)
                    .font(.headline)
                    .foregroundColor(.white)
            }
        }

        private func getAvatarColor(for name: String) -> Color {
            let colors: [Color] = [.blue, .green, .orange, .pink, .purple, .teal, .indigo,
                                   .brown, .black, .cyan, .mint, .primary, .red, .secondary]
            let index = Int.random(in: 0...colors.count-1)
            return colors[index]
        }
    }
}


struct ExamplePatternView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ExamplePatternView()
        }
    }
}
