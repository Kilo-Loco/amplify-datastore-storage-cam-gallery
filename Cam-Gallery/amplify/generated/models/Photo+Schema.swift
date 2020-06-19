// swiftlint:disable all
import Amplify
import Foundation

extension Photo {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case imagePath
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let photo = Photo.keys
    
    model.pluralName = "Photos"
    
    model.fields(
      .id(),
      .field(photo.imagePath, is: .required, ofType: .string)
    )
    }
}