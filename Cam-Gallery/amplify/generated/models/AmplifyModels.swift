// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "e8c82aa3dab246e018ccedbd4d2676d1"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: Photo.self)
  }
}