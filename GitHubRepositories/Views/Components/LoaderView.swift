//
//  LoaderView.swift
//  GitHubRepositories
//
//  Created by Анастасия Конончук on 06.06.2024.
//

import SwiftUI

struct LoaderView: View {
    @State private var isAnimating = false
    
    let color: Color
    let size: CGFloat
    
    var body: some View {
        Circle()
            .trim(from: 0, to: 0.7)
            .stroke(color, lineWidth: 3)
            .frame(width: size, height: size)
            .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
            .animation(
                .linear(duration: 0.8).repeatForever(autoreverses: false),
                value: isAnimating)
            .onAppear {
                isAnimating = true
            }
    }
}

#Preview {
    ZStack {
        Color.black
            .ignoresSafeArea()
        
        LoaderView(color: .white, size: 20)
    }
}
