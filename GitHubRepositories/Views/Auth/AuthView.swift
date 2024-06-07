//
//  AuthView.swift
//  GitHubRepositories
//
//  Created by Анастасия Конончук on 06.06.2024.
//

import SwiftUI

struct AuthView: View {
    @StateObject private var authViewModel = AuthViewModel()
    
    @State private var token = ""
    
    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
            
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .padding()
                        
                            TextField("", text: $token)
                                .placeholder(when: token.isEmpty) {
                                    Text("Personal access token")
                                        .foregroundStyle(.white)
                                        .font(.title)
                                }
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black, lineWidth: 1)
                                )
                                .cornerRadius(10)
                                .foregroundColor(.white)
                                .font(.title2)
                        
                        if let error = authViewModel.error {
                            Text(error)
                                .foregroundStyle(.red)
                                .font(.title3)
                        }
                        
                        Spacer()
                        
                        Button {
                            authViewModel.fetchUser(token: token)
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
                                
                                if authViewModel.isLoading {
                                    LoaderView(color: .white)
                                } else {
                                    Text("Sign up")
                                        .foregroundStyle(.white)
                                        .font(.title)
                                }
                            }
                        }
                    }
                    .padding(16)
                    .frame(minHeight: geometry.size.height)
                }
            }
        }
        .endEditing()
    }
}

#Preview {
    AuthView()
}
