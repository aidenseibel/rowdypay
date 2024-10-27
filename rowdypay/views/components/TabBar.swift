//
//  TabBar.swift
//  Carbonsaurus
//
//  Created by Yash Shah on 2/25/24.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case groups = "square.stack.fill"
    case add = "plus.circle.fill"
    case profile = "person.circle.fill"
}

struct TabBar: View {
    @Binding var selectedTab: Tab

    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: tab.rawValue)
                        .scaleEffect(selectedTab == tab ? 1.3 : 1.0)
                        .foregroundColor(selectedTab == tab ? .accent : .white)

                        .font(.system(size: 22))
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
            .frame(height: UIScreen.main.bounds.height * 0.075)
            .background(Color(.darkGray))
            .cornerRadius(50)
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            .shadow(radius: 10)
        }
    }
}

#Preview {
    TabBar(selectedTab: .constant(.profile))
}
