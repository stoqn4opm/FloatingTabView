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
public struct FloatingTabView<Tab: FloatingTab, TabContent: View, TabIcon: View, TabBarBackgroundView: View>: View {
    @StateObject public var tabRouter: TabRouter<Tab>
    public let tabBarView: CapsuleTabBarView<Tab, TabIcon, TabBarBackgroundView>
    @ViewBuilder public let contentFor: (Tab) -> (TabContent)
    
    
    /// Creates a new instance with given dependencies.
    /// - Parameters:
    ///   - tabRouter: The object that keeps track of the tabs.
    ///   - tabBarView: The view that you want to be presented as a floating tab bar.
    ///   - contentFor: ViewBuilder closure, that needs to provide view content for given tab.
    public init(tabRouter: TabRouter<Tab>, tabBarView: CapsuleTabBarView<Tab, TabIcon, TabBarBackgroundView>, @ViewBuilder contentFor: @escaping (Tab) -> (TabContent)) {
        self._tabRouter = StateObject(wrappedValue: tabRouter)
        self.tabBarView = tabBarView
        self.contentFor = contentFor
    }
    
    public var body: some View {
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
