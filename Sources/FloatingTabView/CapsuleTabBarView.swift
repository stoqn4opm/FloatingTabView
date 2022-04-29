//
//  CapsuleTabBarView.swift
//  
//
//  Created by Stoyan Stoyanov on 29/04/22.
//

import SwiftUI

// MARK: - CapsuleTabBarView Theme

extension CapsuleTabBarView {
    
    struct Theme<Background: View> {
        /// Set a view that will be loaded as a background here. (Typically `Color`)
        let background: Background
        
        /// Controls the spacing between tab icons.
        let interItemSpacing: CGFloat
        
        /// Color that tints the currently selected tab icon.
        let selectedTabColor: Color
        
        /// Color that tints the non selected tabs.
        let nonSelectedTabColor: Color
    }
}

// MARK: - CapsuleTabBarView

/// A view that presents interactive list of `TabIcon`s for each `Tab`, inside the injected `TabRouter`.
struct CapsuleTabBarView<Tab: FloatingTab, TabIcon: View, Background: View>: View {
    
    @StateObject var tabRouter: TabRouter<Tab>
    let theme: Theme<Background>
    @ViewBuilder let tabIconFor: (Tab) -> (TabIcon)
    
    
    var body: some View {
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
