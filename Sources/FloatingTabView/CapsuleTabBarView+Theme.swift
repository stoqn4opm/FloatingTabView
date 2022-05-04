//
//  CapsuleTabBarView+Theme.swift
//  
//
//  Created by Stoyan Stoyanov on 04/05/22.
//

import SwiftUI

// MARK: - CapsuleTabBarView Theme Type

public protocol CapsuleTabBarViewThemeType {
    
    /// Color that fills the background.
    var backgroundColor: Color { get }
    
    /// Controls the spacing between tab icons.
    var interItemSpacing: CGFloat { get }
    
    /// Color that tints the currently selected tab icon.
    var selectedTabColor: Color { get }
    
    /// Color that tints the non selected tabs.
    var nonSelectedTabColor: Color { get }
}

// MARK: - CapsuleTabBarView Theme

/// Concrete type of tab bar theme(local default), enabling simplified creation of themes.
public struct CapsuleTabBarViewTheme: CapsuleTabBarViewThemeType {
    /// Color that fills the background.
    public let backgroundColor: Color
    
    /// Controls the spacing between tab icons.
    public let interItemSpacing: CGFloat
    
    /// Color that tints the currently selected tab icon.
    public let selectedTabColor: Color
    
    /// Color that tints the non selected tabs.
    public let nonSelectedTabColor: Color
    
    
    /// Creates a new instance, for injecting into a `CapsuleTabBarView`.
    ///
    /// - Parameters:
    ///   - backgroundColor: Color that fills the background.
    ///   - interItemSpacing: Controls the spacing between tab icons.
    ///   - selectedTabColor: Color that tints the currently selected tab icon.
    ///   - nonSelectedTabColor: Color that tints the non selected tabs.
    public init(backgroundColor: Color, interItemSpacing: CGFloat, selectedTabColor: Color, nonSelectedTabColor: Color) {
        self.backgroundColor = backgroundColor
        self.interItemSpacing = interItemSpacing
        self.selectedTabColor = selectedTabColor
        self.nonSelectedTabColor = nonSelectedTabColor
    }
}
