//
//  LoadingButton.swift
//  AI Chat
//
//  Created by Johan Wigmo on 2023-04-11.
//

import SwiftUI

struct LoadingButton: View {
    let title: String
    @Binding var isLoading: Bool
    let action: () -> Void

    var body: some View {
        Button(action: {
            isLoading = true
            action()
        }) {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .foregroundColor(.white)
                    .padding()
            } else {
                Text(title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.blue)
        .cornerRadius(10)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingButton(title: "Title", isLoading: .constant(false), action: {})
    }
}
