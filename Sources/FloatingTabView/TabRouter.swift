//
//  TabRouter.swift
//  
//
//  Created by Stoyan Stoyanov on 29/04/22.
//

import SwiftUI


/// The "tabs" with which the `FloatingTabView` works with.
protocol FloatingTab: Identifiable, Equatable { }

/// Observable object, that holds reference to `Tab`s and currently selected tab.
class TabRouter<Tab: FloatingTab>: ObservableObject {
    
    @Published var currentTab: Tab
    
    let tabs: [Tab]
    
    init(tabs: [Tab], initiallySelectedTab: Tab) {
        self.tabs = tabs
        self.currentTab = initiallySelectedTab
    }
}
