//
//  SettingsView.swift
//  AI Chat
//
//  Created by Johan Wigmo on 2023-04-10.
//

import SwiftUI
import Combine

struct SettingsView: View {

    @State private var isLoading = false
    @State private var showAlert = false
    @State private var isValid = false
    @State private var key: String = UserDefaults.ApiKey {
        didSet {
            UserDefaults.ApiKey = key
        }
    }

    var body: some View {
        VStack {
            Text("Settings")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            TextFieldView(
                title: "Open AI API key",
                placeholder: "API Key",
                text: $key)
            .padding(.horizontal)
            LoadingButton(
                title: "Validate",
                isLoading: $isLoading)
            {
                validate()
            }
            .padding(.all)
            Button(action: {
                guard let url = URL(string: "https://platform.openai.com/overview") else { return }
                    UIApplication.shared.open(url)
                // Handle button action here
            }) {
                Text("Obtain an API key")
                    .underline()
                    .foregroundColor(.blue)
            }
            .padding(.all)
            Spacer()

        }

        .alert(isPresented: $showAlert,
            content: {
            Alert(
                title: Text(isValid ? "Valid" : "Invalid"),
                message: nil,
                dismissButton: .default(Text("OK")))
        })
    }
}

private extension SettingsView {

    func validate() {
        API.shared.validate { isValid, error in
            self.isLoading = false
            if let _ = error {
                self.isValid = false
                self.showAlert = true
                return
            }

            self.isValid = isValid
            self.showAlert = true
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
