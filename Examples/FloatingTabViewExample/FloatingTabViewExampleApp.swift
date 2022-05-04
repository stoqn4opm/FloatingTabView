//
//  FloatingTabViewExampleApp.swift
//  FloatingTabViewExample
//
//  Created by Stoyan Stoyanov on 29/04/22.
//

import SwiftUI
import FloatingTabView

@main
struct FloatingTabViewExampleApp: App {

    @State private var barOffset: CGFloat = 10

    var body: some Scene {
        WindowGroup {
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
            
            FloatingTabView(tabRouter: router, barOffset: $barOffset, barPadding: .constant(20), tabBarView: bar) { tab in
                switch tab {
                case .home:
                    Group {
                        Rectangle()
                            .foregroundColor(.yellow)
                        Text("Home")
                            .background(Color.red)
                    }
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                            barOffset = barOffset == 0 ? 1 : 0
                        }
                    }
                case .search:
                    Group {
                        Rectangle()
                            .foregroundColor(.cyan)
                        Text("Liked")
                            .background(Color.red)
                    }
                    .edgesIgnoringSafeArea(.all)
                case .user:
                    Group {
                        Rectangle()
                            .foregroundColor(.purple)
                        Text("User")
                            .background(Color.red)
                    }
                    .edgesIgnoringSafeArea(.all)
                }
            }
        }
    }
}
