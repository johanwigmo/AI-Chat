//
//  LoadingChatRow.swift
//  AI Chat
//
//  Created by Johan Wigmo on 2023-04-13.
//

import SwiftUI

struct LoadingChatRow: View {

    @State private var title = "     "
    private let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()

    var body: some View {
        HStack {
            Text(title)
                .padding(10)
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
            Spacer()
        }
        .padding(.vertical, 5)

        .onReceive(timer) { _ in
            switch title {
            case "     ": title = ".    "
            case ".    ": title = ". .  "
            case ". .  ": title = ". . ."
            default: title = "     "
            }
        }
    }
}

struct LoadingChatRow_Previews: PreviewProvider {
    static var previews: some View {
        LoadingChatRow()
    }
}
