//
//  ButtonView.swift
//  GitHubRepositories
//
//  Created by Анастасия Конончук on 09.06.2024.
//

import SwiftUI

struct ButtonView: View {
    private let text: String
    private let isLoading: Bool
    private let action: () -> Void
    
    init(text: String, isLoading: Bool = false, action: @escaping () -> Void) {
        self.text = text
        self.isLoading = isLoading
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.purple)
                    .frame(height: 48)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .shadow(radius: 5)
                
                if isLoading {
                    LoaderView(color: .white, size: 20)
                } else {
                    Text(text)
                        .foregroundStyle(.white)
                        .font(.title)
                }
            }
        }
    }
}

#Preview {
    ButtonView(text: "Sign up", isLoading: false, action: {})
}
