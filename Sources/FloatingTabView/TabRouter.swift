//
//  TabRouter.swift
//  
//
//  Created by Stoyan Stoyanov on 29/04/22.
//

import SwiftUI


/// The "tab" type with which the `FloatingTabView` works with.
public protocol FloatingTab: Identifiable, Equatable { }

/// Observable object, that holds reference to `Tab`s and currently selected tab.
open class TabRouter<Tab: FloatingTab>: ObservableObject {
    
    @Published public var currentTab: Tab
    
    public let tabs: [Tab]
    
    public init(tabs: [Tab], initiallySelectedTab: Tab) {
        self.tabs = tabs
        self.currentTab = initiallySelectedTab
    }
}
