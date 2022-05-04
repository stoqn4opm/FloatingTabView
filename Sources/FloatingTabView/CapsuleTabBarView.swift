//
//  CapsuleTabBarView.swift
//  
//
//  Created by Stoyan Stoyanov on 29/04/22.
//

import SwiftUI

// MARK: - CapsuleTabBarView

/// A view that presents interactive list of `TabIcon`s for each `Tab`, inside the injected `TabRouter`.
public struct CapsuleTabBarView<Tab: FloatingTab, TabIcon: View>: View {
    @StateObject public var tabRouter: TabRouter<Tab>
    public let theme: CapsuleTabBarViewThemeType
    @ViewBuilder public let tabIconFor: (Tab) -> (TabIcon)
    
    
    /// Creates a new instance with given dependencies.
    /// - Parameters:
    ///   - tabRouter: The object that keeps track of the tabs.
    ///   - theme: Container holding appearance configuration for this instance.
    ///   - tabIconFor: ViewBuilder closure, that needs to provide tab icon for given tab.
    public init(tabRouter: TabRouter<Tab>, theme: CapsuleTabBarViewThemeType, @ViewBuilder tabIconFor: @escaping (Tab) -> (TabIcon)) {
        self._tabRouter = StateObject(wrappedValue: tabRouter)
        self.theme = theme
        self.tabIconFor = tabIconFor
    }
    
    public var body: some View {
        HStack {
            Spacer()
            HStack(spacing: theme.interItemSpacing) {
                ForEach(tabRouter.tabs) { tab in
                    tabIconFor(tab)
                        .foregroundColor(tabRouter.currentTab == tab ? theme.selectedTabColor : theme.nonSelectedTabColor)
                        .onTapGesture {
                            tabRouter.currentTab = tab
                        }
                }
            }
            .background(theme.backgroundColor)
            .clipShape(Capsule())
            Spacer()
        }
    }
}
