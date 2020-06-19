// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "a2fbd7882a214d9e20944fc932ecfeda"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: Photo.self)
  }
}