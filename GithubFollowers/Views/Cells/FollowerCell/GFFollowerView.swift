//
//  GFFollowerView.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 25.10.2023.
//

import SwiftUI

struct GFFollowerView: View {
    var follower: GFFollower
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: follower.avatarUrl)) {
                image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Image("avatar-placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .clipShape(Circle())
            
            Text(follower.login)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.6)
        }
    }
}

#Preview {
    GFFollowerView(follower: GFFollower(login: "Ahmettarikdoener", avatarUrl: ""))
}
