//
//  Onboarding.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import SwiftUI

struct Onboarding: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @State var logInUsername:String = ""
    @State var logInPassword:String = ""

    @State var signUpUsername:String = ""
    @State var signUpEmail:String = ""
    @State var signUpPassword:String = ""
    @State var signUpPasswordConfirm:String = ""
    @State var displayName: String = ""
    
    @State var onboardingMode: String = "Log In"
    var onboardingOptions: [String] = ["Log In", "Sign Up"]
    
    @State var fieldsAreNotValid: Bool = false
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(alignment: .leading, spacing: 30){
                Text("Welcome to RowdyPay")
                    .font(.system(size: 42))
                    .bold()

                Picker("driving", selection: $onboardingMode) {
                    ForEach(onboardingOptions, id: \.self){option in
                        Text("\(option)")
                    }
                }.pickerStyle(.segmented).shadow(radius: 8)
                
                
                if onboardingMode == "Log In"{
                    VStack(alignment: .leading, spacing: 10){
                        TextField("Username or email...", text: $logInUsername)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                            .padding(10)
                            .background(Color(.darkerGray))
                            .cornerRadius(10)
                        SecureField("Password...", text: $logInPassword)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .padding(10)
                            .background(Color(.darkerGray))
                            .cornerRadius(10)
                        
                        
                        Button {
                            if logInFieldsAreValid(){
                                viewModel.hasOnboarded = true
                            }
                        } label: {
                            Text("Submit")
                                .font(.system(size: 24, weight: .bold, design: .default))
                                .padding(3)
                        }
                    }
                }
                
                else{
                    VStack(alignment: .leading, spacing: 10){
                        TextField("First Name...", text: $displayName)
                            .autocorrectionDisabled()
                            .padding(10)
                            .background(Color(.darkerGray))
                            .cornerRadius(10)
                        TextField("Username...", text: $signUpUsername)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .padding(10)
                            .background(Color(.darkerGray))
                            .cornerRadius(10)
                        TextField("Email...", text: $signUpEmail)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                            .padding(10)
                            .background(Color(.darkerGray))
                            .cornerRadius(10)
                        SecureField("Password...", text: $signUpPassword)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .padding(10)
                            .background(Color(.darkerGray))
                            .cornerRadius(10)
                        SecureField("Confirm Password...", text: $signUpPasswordConfirm)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .padding(10)
                            .background(Color(.darkerGray))
                            .cornerRadius(10)
                      
                            
                        Button {
                            if signUpFieldsAreValid(){
                                viewModel.hasOnboarded = true
                            }
                        } label: {
                            Text("Submit")
                                .font(.system(size: 24, weight: .bold, design: .default))
                                .padding(3)
                        }
                    }
                }

                if fieldsAreNotValid{
                    Text("Ensure all fields are valid.")
                        .foregroundStyle(.red)
                }
            }
            .padding()
        }
    }
    
    func logInFieldsAreValid() -> Bool{
        if !logInUsername.isEmpty && !logInPassword.isEmpty{
            return true
        }
        fieldsAreNotValid = true
        return false
    }
    
    func signUpFieldsAreValid() -> Bool{
        if !signUpUsername.isEmpty && !signUpPassword.isEmpty && (signUpPassword == signUpPasswordConfirm){
            return true
        }
        fieldsAreNotValid = true
        return false
    }
}

#Preview {
    Onboarding()
}
