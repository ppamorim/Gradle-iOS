import Foundation

extension String {
  var localized : String {
    return NSLocalizedString(self, value: "", comment: "")
  }
}