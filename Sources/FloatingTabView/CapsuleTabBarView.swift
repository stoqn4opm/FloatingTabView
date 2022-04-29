//
//  CapsuleTabBarView.swift
//  
//
//  Created by Stoyan Stoyanov on 29/04/22.
//

import SwiftUI

// MARK: - CapsuleTabBarView Theme

extension CapsuleTabBarView {
    
    public struct Theme<Background: View> {
        /// Set a view that will be loaded as a background here. (Typically `Color`)
        let background: Background
        
        /// Controls the spacing between tab icons.
        let interItemSpacing: CGFloat
        
        /// Color that tints the currently selected tab icon.
        let selectedTabColor: Color
        
        /// Color that tints the non selected tabs.
        let nonSelectedTabColor: Color
        
        
        /// Creates a new instance, for injecting into a `CapsuleTabBarView`.
        ///
        /// - Parameters:
        ///   - background: Set a view that will be loaded as a background here. (Typically `Color`)
        ///   - interItemSpacing: Controls the spacing between tab icons.
        ///   - selectedTabColor: Color that tints the currently selected tab icon.
        ///   - nonSelectedTabColor: Color that tints the non selected tabs.
        public init(background: Background, interItemSpacing: CGFloat, selectedTabColor: Color, nonSelectedTabColor: Color) {
            self.background = background
            self.interItemSpacing = interItemSpacing
            self.selectedTabColor = selectedTabColor
            self.nonSelectedTabColor = nonSelectedTabColor
        }
    }
}

// MARK: - CapsuleTabBarView

/// A view that presents interactive list of `TabIcon`s for each `Tab`, inside the injected `TabRouter`.
public struct CapsuleTabBarView<Tab: FloatingTab, TabIcon: View, Background: View>: View {
    @StateObject public var tabRouter: TabRouter<Tab>
    public let theme: Theme<Background>
    @ViewBuilder public let tabIconFor: (Tab) -> (TabIcon)
    
    
    /// Creates a new instance with given dependencies.
    /// - Parameters:
    ///   - tabRouter: The object that keeps track of the tabs.
    ///   - theme: Container holding appearance configuration for this instance.
    ///   - tabIconFor: ViewBuilder closure, that needs to provide tab icon for given tab.
    public init(tabRouter: TabRouter<Tab>, theme: CapsuleTabBarView<Tab, TabIcon, Background>.Theme<Background>, @ViewBuilder tabIconFor: @escaping (Tab) -> (TabIcon)) {
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
            .background(theme.background)
            .clipShape(Capsule())
            Spacer()
        }
    }
}
