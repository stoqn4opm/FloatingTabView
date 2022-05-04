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
public struct FloatingTabView<Tab: FloatingTab, TabContent: View, TabBarView: View>: View {
    @StateObject public var tabRouter: TabRouter<Tab>
    @Binding public var barOffset: CGFloat
    @Binding public var barPadding: CGFloat
    public let tabBarView: TabBarView
    @ViewBuilder public let contentFor: (Tab) -> (TabContent)
    
    /// Creates a new instance with given dependencies.
    /// - Parameters:
    ///   - tabRouter: The object that keeps track of the tabs.
    ///   - tabBarView: The view that you want to be presented as a floating tab bar.
    ///   - contentFor: ViewBuilder closure, that needs to provide view content for given tab.
    ///   - barOffset: Controls the position of the floating tab bar. 0 being hidden away,
    ///    1 being situated in its designated space.
    ///   - barPadding: The distance from the bottom of the floating tab to the bottom edge
    public init(tabRouter: TabRouter<Tab>,
                barOffset: Binding<CGFloat>,
                barPadding: Binding<CGFloat>,
                tabBarView: TabBarView,
                @ViewBuilder contentFor: @escaping (Tab) -> (TabContent)) {
        
        self._tabRouter = StateObject(wrappedValue: tabRouter)
        self._barOffset = barOffset
        self._barPadding = barPadding
        self.tabBarView = tabBarView
        self.contentFor = contentFor
    }
    
    public var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .barAlignment)) {
            ZStack(alignment: .center) {
                contentFor(tabRouter.currentTab)
            }
            .alignmentGuide(.barAlignment) { $0[.bottom] }
            tabBarView
                .alignmentGuide(.barAlignment, computeValue: computedBarAlignment(for:))
        }
    }
    
    private func computedBarAlignment(for viewDimensions: ViewDimensions) -> CGFloat {
        let bottom = viewDimensions[.top] - barPadding
        let top = viewDimensions[.bottom] + barPadding
        
        let safeOffset = max(0, min(1, barOffset))
        return (1 - safeOffset) * bottom + safeOffset * top
    }
}

// MARK: - Custom Bar Alignment

extension VerticalAlignment {
    private enum BarAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context.height
        }
    }
    
    static let barAlignment = VerticalAlignment(BarAlignment.self)
}
