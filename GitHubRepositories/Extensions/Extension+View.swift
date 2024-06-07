//
//  Extension+View.swift
//  GitHubRepositories
//
//  Created by Анастасия Конончук on 06.06.2024.
//

import SwiftUI

extension View {
    func placeholder(
        when isShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> some View
    ) -> some View {
        ZStack(alignment: alignment) {
            self
            
            placeholder()
                .allowsHitTesting(false)
                .opacity(isShow ? 1 : 0)
        }
    }
    
    func endEditing() -> some View {
        self
            .onTapGesture {
                UIApplication.shared.sendAction(
                    #selector(UIResponder.resignFirstResponder),
                    to: nil,
                    from: nil,
                    for: nil
                )
            }
    }
}
