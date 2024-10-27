//
//  CirclesView.swift
//  rowdypay
//
//  Created by Khoi Tran on 10/27/24.
//

import SwiftUI

struct CirclesView: View {
    
    @State var moving = false
    
    var body: some View {
        ZStack {
            
            ForEach(0 ..< 10) { item in
                Circle()
                    .stroke(
                        LinearGradient(colors: [.red, .accent, .yellow], startPoint: .top, endPoint: .bottom)
                    )
                    .frame(width: 30 * CGFloat(item), height: 40 * CGFloat(item))
                    .rotation3DEffect(.degrees(45), axis: (x: 1 , y: 0, z: 0))
                    .offset(y: moving ? 0 * CGFloat(item) : -400)
                    .animation(.interpolatingSpring(stiffness: 25, damping: 10).repeatForever(autoreverses: true).delay(0.05 * CGFloat(item)), value: moving)
                    .shadow(color: .red, radius: 24)
                    .shadow(color: .accent, radius: 24)
                    .shadow(color: .yellow, radius: 24)

            }
            
            ForEach(0 ..< 10) { item in
                Circle()
                    .stroke(
                        LinearGradient(colors: [.yellow, .accent, .red], startPoint: .bottom, endPoint: .top)
                    )
                    .frame(width: 30 * CGFloat(item), height: 40 * CGFloat(item))
                    .rotation3DEffect(.degrees(45), axis: (x: 1 , y: 0, z: 0))
                    .offset(y: moving ? 0 * CGFloat(item) : 400)
                    .animation(.interpolatingSpring(stiffness: 25, damping: 10).repeatForever(autoreverses: true).delay(0.05 * CGFloat(item)), value: moving)
                    .shadow(color: .yellow, radius: 24)
                    .shadow(color: .accent, radius: 24)
                    .shadow(color: .red, radius: 24)

            }
        }
        .onAppear {
            moving.toggle()
        }
    }
    
}

struct CirclesView_Previews: PreviewProvider {
    static var previews: some View {
        CirclesView()
            .preferredColorScheme(.dark)
    }
}
