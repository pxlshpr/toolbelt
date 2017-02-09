import UIKit

//TODO: Move this to Toolbelt after we add it there with tests!
//modified from: http://stackoverflow.com/a/29044899
//which is originally derived from: https://www.w3.org/WAI/ER/WD-AERT/#color-contrast
extension UIColor {
  //TODO: try and make these variables
  func isLight() -> Bool {
    guard let components = self.cgColor.components else {
      return false
    }
    
    let componentColorR: CGFloat = components[0] * 299
    let componentColorG: CGFloat = components[1] * 587
    let componentColorB: CGFloat = components[2] * 114
    
    let brightness = componentColorR + componentColorG + componentColorB
    return brightness >= 500 //try up to 700 too (tests should reveal this!)
  }
  
  func barStyle() -> UIBarStyle {
    return isLight() ? .default : .black
  }
}

public extension UIColor {
  
  
  /**
   Initializes and returns a color object using the provided string representation of a hexadecimal number.
   
   - parameters:
   - hexString: The hexadecimal number of the color, represented as a string. It may be optionally prepended with the '#' symbol.
   
   - returns:
   The color object for the provided hexadecimal, if valid. If an invalid hexadecimal number is provided, UIColor.black is returned.
   */
  
  public convenience init?(hexString: String) {
    let hex = hexString.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
    guard hex.isValidHexadecimal else {
      return nil
    }
    
    var int = UInt32()
    Scanner(string: hex).scanHexInt32(&int)
    let a, r, g, b: UInt32
    switch hex.characters.count {
    case 3: // RGB (12-bit)
      (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
    case 6: // RGB (24-bit)
      (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
    default:
      (a, r, g, b) = (255, 0, 0, 0)
    }
    self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
  }
}
