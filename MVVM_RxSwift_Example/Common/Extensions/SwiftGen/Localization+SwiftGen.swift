// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable function_parameter_count identifier_name line_length type_body_length
internal enum L10n {
  /// EXPLORE
  internal static let exploreTabTitle = L10n.tr("Localizable", "exploreTabTitle")
  /// MAP
  internal static let mapTabTitle = L10n.tr("Localizable", "mapTabTitle")
  /// ORDERS
  internal static let ordersTabTitle = L10n.tr("Localizable", "ordersTabTitle")
  /// PROFILE
  internal static let profileTabTitle = L10n.tr("Localizable", "profileTabTitle")
  /// break
  internal static let settingsBreakDuration = L10n.tr("Localizable", "settingsBreakDuration")
  /// daily goal
  internal static let settingsDailyGoal = L10n.tr("Localizable", "settingsDailyGoal")
  /// long break
  internal static let settingsLongBreak = L10n.tr("Localizable", "settingsLongBreak")
  /// sessions until long break
  internal static let settingsSessionsUntilLongBreak = L10n.tr("Localizable", "settingsSessionsUntilLongBreak")
  /// work
  internal static let settingsWorkDuration = L10n.tr("Localizable", "settingsWorkDuration")
  /// Error
  internal static let alertDefaultErrorTile = L10n.tr("Localizable", "alert.default_error_tile")
  /// Information
  internal static let alertDefaultInfoTile = L10n.tr("Localizable", "alert.default_info_tile")
  /// Success
  internal static let alertDefaultSuccessTile = L10n.tr("Localizable", "alert.default_success_tile")
  /// Login testing again
  internal static let authLoginButtonTitle = L10n.tr("Localizable", "auth.login_button.title")
  /// OK
  internal static let commonButtonsOkButtonTitle = L10n.tr("Localizable", "common_buttons.ok_button.title")
  /// Save
  internal static let commonButtonsSaveButtonTitle = L10n.tr("Localizable", "common_buttons.save_button.title")
  /// Cannot login, please try again later
  internal static let errorCannotLogin = L10n.tr("Localizable", "error.cannot_login")
  /// Something went wrong, please try again later
  internal static let errorUndefined = L10n.tr("Localizable", "error.undefined")
}
// swiftlint:enable function_parameter_count identifier_name line_length type_body_length

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
