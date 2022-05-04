


# FloatingTabView
![](https://img.shields.io/badge/version-1.0-brightgreen.svg)

`FloatingTabView` is SwiftUI component whose tab bar "floats" above the tabs content. It mimics the functionality of `TabView`.

It provides the basic behaviour while leaving you to do the UI cistomizations and providing the content that needs to be presented 
when a tab is switched.

Build using Swift 5.6, XCode 13.3.1, supports iOS 14.0+

# Preview

![](https://raw.githubusercontent.com/stoqn4opm/FloatingTabView/master/Preview/FloatingTabView-preview.gif)

# Usage

You can use **FloatingTabView** like any other SwiftUI view, by invoking its initialiser and injecting all of its required 
dependencies:
```swift
/// Custom implementation of `TabView`, whose tab bar "floats" above the tabs content.
/// Tabs can be switched with the help of the `tabRouter`, that could be passed to the tab bar that you will present,
/// so that the tab bar can have a way to switch the tabs.
///
/// When initializing it, you need to pass a view builder closure
/// that needs to return the view content for a given tab,
/// and a view that will be used as a tab bar.
public struct FloatingTabView<Tab: FloatingTab, TabContent: View, TabBarView: View>: View {

    public var tabRouter: TabRouter<Tab> { get }

    public var barOffset: CGFloat { get nonmutating set }

    public var barPadding: CGFloat { get nonmutating set }

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
    public init(tabRouter: TabRouter<Tab>, barOffset: Binding<CGFloat>, barPadding: Binding<CGFloat>, tabBarView: TabBarView, 
@ViewBuilder contentFor: @escaping (Tab) -> (TabContent))
}
```
Where `TabRouter` is `ObservableObject`, that holds reference to all `Tab`s and the currently selected tab. `FloatingTab`s are the 
models with which the component is working. They act as tab identifiers, and later you are asked to provide tab icon and tab content 
for them.
```swift
///  The "tab" type with which the `FloatingTabView` works with.
public  protocol  FloatingTab: Identifiable, Equatable { }
```

A sample implementation for a tab bar view that you can use in `FloatingTabView` is provided in **CapsuleTabBarView**:
```swift
/// A view that presents interactive list of `TabIcon`s for each `Tab`, inside the injected `TabRouter`.
public struct CapsuleTabBarView<Tab, TabIcon> : View where TabIcon : View {

    public var tabRouter: TabRouter<Tab> { get }

    public let theme: CapsuleTabBarViewThemeType

    @ViewBuilder public let tabIconFor: (Tab) -> (TabIcon)

    /// Creates a new instance with given dependencies.
    /// - Parameters:
    ///   - tabRouter: The object that keeps track of the tabs.
    ///   - theme: Container holding appearance configuration for this instance.
    ///   - tabIconFor: ViewBuilder closure, that needs to provide tab icon for given tab.
    public init(tabRouter: TabRouter<Tab>, theme: CapsuleTabBarViewThemeType, @ViewBuilder tabIconFor: @escaping (Tab) -> (TabIcon))
}
```

*If you need more info, have a look at the example project.*

# Customisation

`CapsuleTabBarView`s require you to pass a `theme` during initialisation, with which you can tweak its appearance:

``` swift
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
```


# Installation

### Swift Package Manager

1. Navigate to `XCode project` > `ProjectName` > `Swift Packages` > `+ (add)`
2. Paste the url `https://github.com/stoqn4opm/FloatingTabView.git`
3. Select the needed targets.
