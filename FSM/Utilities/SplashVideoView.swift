//
//  SplashVideoView.swift
//  FSM
//
//  Created by AlMaalik's Mac on 15/02/26.
//


import SwiftUI
import AVFoundation

struct SplashVideoView: View {
    
    @State private var isActive = false
    
    var body: some View {
        ZStack {
            
            Color.white
                .ignoresSafeArea()
            
            if !isActive {
                SplashPlayerRepresentable(isActive: $isActive)
                    .ignoresSafeArea()
            } else {
                ServicesListView()
            }
        }
    }
}


struct SplashPlayerRepresentable: UIViewRepresentable {
    
    @Binding var isActive: Bool
    
    func makeUIView(context: Context) -> PlayerView {
        let view = PlayerView()
        
        guard let path = Bundle.main.path(forResource: "ZuperSplash", ofType: "mov") else {
            return view
        }
        
        let url = URL(fileURLWithPath: path)
        let player = AVPlayer(url: url)
        
        view.playerLayer.player = player
        view.playerLayer.videoGravity = .resizeAspect   
        view.backgroundColor = .white
        
        player.play()
        
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main
        ) { _ in
            withAnimation(.easeInOut(duration: 0.4)) {
                isActive = true
            }
        }
        
        return view
    }
    
    func updateUIView(_ uiView: PlayerView, context: Context) {}
}

class PlayerView: UIView {
    
    override static var layerClass: AnyClass {
        AVPlayerLayer.self
    }
    
    var playerLayer: AVPlayerLayer {
        layer as! AVPlayerLayer
    }
}

