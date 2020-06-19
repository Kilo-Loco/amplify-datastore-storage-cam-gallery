// swiftlint:disable all
import Amplify
import Foundation

public struct Photo: Model {
  public let id: String
  public var imagePath: String
  
  public init(id: String = UUID().uuidString,
      imagePath: String) {
      self.id = id
      self.imagePath = imagePath
  }
}