// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable sorted_imports
import Foundation
import UIKit

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Storyboard Scenes

// swiftlint:disable explicit_type_interface identifier_name line_length type_body_length type_name
internal enum StoryboardScene {
  internal enum Authentication: StoryboardType {
    internal static let storyboardName = "Authentication"

    internal static let authenticationViewController = SceneType<MVVM_RxSwift_Example.AuthenticationViewController>(storyboard: Authentication.self, identifier: "AuthenticationViewController")
  }
  internal enum Explore: StoryboardType {
    internal static let storyboardName = "Explore"

    internal static let exploreViewContoller = SceneType<MVVM_RxSwift_Example.ExploreViewController>(storyboard: Explore.self, identifier: "ExploreViewContoller")
  }
  internal enum GenericPickerViewController: StoryboardType {
    internal static let storyboardName = "GenericPickerViewController"

    internal static let initialScene = InitialSceneType<MVVM_RxSwift_Example.GenericPickerViewController>(storyboard: GenericPickerViewController.self)

    internal static let genericPickerViewController = SceneType<MVVM_RxSwift_Example.GenericPickerViewController>(storyboard: GenericPickerViewController.self, identifier: "GenericPickerViewController")
  }
  internal enum Map: StoryboardType {
    internal static let storyboardName = "Map"

    internal static let mapViewController = SceneType<MVVM_RxSwift_Example.MapViewController>(storyboard: Map.self, identifier: "MapViewController")
  }
  internal enum Orders: StoryboardType {
    internal static let storyboardName = "Orders"

    internal static let ordersViewController = SceneType<MVVM_RxSwift_Example.OrdersViewController>(storyboard: Orders.self, identifier: "OrdersViewController")
  }
  internal enum Profile: StoryboardType {
    internal static let storyboardName = "Profile"

    internal static let profileViewController = SceneType<MVVM_RxSwift_Example.ProfileViewController>(storyboard: Profile.self, identifier: "ProfileViewController")
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length type_body_length type_name

// MARK: - Implementation Details

internal protocol StoryboardType {
  static var storyboardName: String { get }
}

internal extension StoryboardType {
  static var storyboard: UIStoryboard {
    let name = self.storyboardName
    return UIStoryboard(name: name, bundle: Bundle(for: BundleToken.self))
  }
}

internal struct SceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type
  internal let identifier: String

  internal func instantiate() -> T {
    let identifier = self.identifier
    guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
      fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
    }
    return controller
  }
}

internal struct InitialSceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type

  internal func instantiate() -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
      fatalError("ViewController is not of the expected class \(T.self).")
    }
    return controller
  }
}

private final class BundleToken {}
