//
//  AccountView.swift
//  OpenBook
//
//  Created by Sean Molenaar on 19/07/2023.
//

import SwiftUI
import OpenLibraryKit

struct AccountView: View {
    @AppStorage("username") var username: String?
    let api: OpenLibraryKit = OpenLibraryKit()
    @State var profile: Profile? = nil

    var body: some View {
        VStack {
            if let profile = profile {
                Text("Hello \(profile.displayname)")
                Text("Created: \(profile.created.value!.description)")
            }
        }.onAppear {
            guard let username = username else { return }
            Task {
                if let profile = try? await api.profile.get(user: username) {
                    self.profile = profile
                }
            }
        }
    }
}

#Preview {
    AccountView()
}
