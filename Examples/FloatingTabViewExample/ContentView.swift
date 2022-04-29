//
//  ContentView.swift
//  FloatingTabViewExample
//
//  Created by Stoyan Stoyanov on 29/04/22.
//

import SwiftUI
import FloatingTabView

enum ExampleAppTab: String, FloatingTab, CaseIterable {
    
    var id: String { rawValue }
    
    case home
    case search
    case user
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let router = TabRouter<ExampleAppTab>(tabs: [.home, .search, .user], initiallySelectedTab: .home)
        
        let bar = CapsuleTabBarView(tabRouter: router,
                                    theme: .init(background: Color.white,
                                                  interItemSpacing: 10,
                                                 selectedTabColor: Color.red,
                                                  nonSelectedTabColor: .gray)) { tab in
            switch tab {
            case .home: SystemImageTabIconView(systemImageName: "homekit")
            case .search: SystemImageTabIconView(systemImageName: "heart")
            case .user: SystemImageTabIconView(systemImageName: "person.crop.circle")
            }
        }
                                     
        return FloatingTabView(tabRouter: router, tabBarView: bar) { tab in
            switch tab {
            case .home:
                Rectangle()
                    .foregroundColor(.yellow)
                Text("Home")
                    .background(Color.red)
            case .search:
                Rectangle()
                    .foregroundColor(.cyan)
                Text("Liked")
                    .background(Color.red)
            case .user:
                Rectangle()
                    .foregroundColor(.purple)
                Text("User")
                    .background(Color.red)
            }
        }
        .preferredColorScheme(.light)
    }
}

struct SystemImageTabIconView: View {
    
    let systemImageName: String
    
    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 18, height: 18)
            .padding()
    }
}
