//
//  FloatingTabView.swift
//
//
//  Created by Stoyan Stoyanov on 29/04/22.
//

import SwiftUI

// MARK: - FloatingTabView

/// Custom implementation of `TabView`, whose tab bar "floats" above the tabs content.
/// Tabs can be switched with the help of the `tabRouter`, that could be passed to the tab bar that you will present,
/// so that the tab bar can have a way to switch the tabs.
///
/// When initializing it, you need to pass a view builder closure
/// that needs to return the view content for a given tab,
/// and a view that will be used as a tab bar.
struct FloatingTabView<Tab: FloatingTab, TabContent: View, TabIcon: View, TabBarBackgroundView: View>: View {
    
    @StateObject var tabRouter: TabRouter<Tab>
    let tabBarView: CapsuleTabBarView<Tab, TabIcon, TabBarBackgroundView>
    @ViewBuilder let contentFor: (Tab) -> (TabContent)
    
    var body: some View {
        ZStack {
            contentFor(tabRouter.currentTab)
            VStack {
                Spacer()
                tabBarView
                    .padding()
            }
        }
    }
}
