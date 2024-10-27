//
//  ReliabilityReportView.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/27/24.
//

import SwiftUI

struct ReliabilityReportView: View {
//    @EnvironmentObject var viewModel: ViewModel
    let screenWidth = UIScreen.main.bounds.width


    var body: some View {
        ScrollView{
            VStack(spacing: 30){
                Image("a")
                    .resizable()
                    .frame(width: screenWidth * 0.60, height: screenWidth * 0.60)
                    .cornerRadius(screenWidth * 0.35)
                    .padding()

                VStack{
                    Text("Your Reliability is")
                        .font(.system(size: 14))
                    Text("Stellar")
                        .font(.system(size: 32))
                        .bold()
                }

                Text("From what we can tell, you make regular payments to your groups on a punctual basis. ")
                    .multilineTextAlignment(.center)
                    .frame(width: screenWidth * 0.70)
                
                Text("Good job!")
            }
            .padding(10)
        }
        .navigationTitle("Reliability Report")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    ReliabilityReportView()
}
