//
//  SettingsTab.swift
//  Swift Co-Pilot
//
//  Created by Prabaljit Walia on 12/08/21.
//

import SwiftUI

import SwiftUI
import UIKit
import MessageUI

struct SetttingsTab: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var showSheet = false
    
    @State var result: Result? = nil
    
    var body: some View {
        NavigationView {
            
            List {
                Section {
                    Button(action: {
                        self.showFeatures()
                    }) {
                        SettingsCell(title: "Features", imgName: "sparkles", clr: .orange)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                }
                
                Section {
                    Button(action: {
                        self.writeReview()
                    }) {
                        SettingsCell(title: "Write a Review", imgName: "pencil.and.outline", clr: .orange)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                    
                    Button(action: {
                        self.shareWithFriends()
                    }) {
                        SettingsCell(title: "Tell your friends", imgName: "gift", clr: .orange)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                }
                
                Section {
                    Button(action: {
                        self.suggestFeature()
                    }) {
                        SettingsCell(title: "Suggest a feature", imgName: "star.circle", clr: .orange)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                    
                    Button(action: {
                        self.reportBug()
                    }) {
                        SettingsCell(title: "Report a bug", imgName: "exclamationmark.triangle", clr: .orange)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                }
                }.listStyle(InsetGroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
            
            .navigationBarTitle("Settings")

            
        }
    }
    
    func showFeatures() {
        print("Show User Features")
    }
    
    func writeReview() {
        print("Go To App Store")
        
        let appURL = URL(string: "https://apps.apple.com/app/id1500146123")!
        
        var components = URLComponents(url: appURL, resolvingAgainstBaseURL: false)
        
        components?.queryItems = [URLQueryItem(name: "action", value: "write-review")]
        
        guard let writeReviewURL = components?.url else {return}
        
        UIApplication.shared.open(writeReviewURL)
    }
    
    func shareWithFriends() {
        print("Yeah! Look At This Bro")
    }
    
    func suggestFeature() {
        print("Hurray! New Suggestion")
        if MFMailComposeViewController.canSendMail() {
            self.showSheet = true
        } else {
            print("Error sending mail")
            // Alert : Unable to send the mail
        }
    }
    
    func reportBug() {
        print("Bug Detected")
    }
}


struct SetttingsTab_Previews: PreviewProvider {
    static var previews: some View {
        SetttingsTab().preferredColorScheme(.dark)
    }
}
