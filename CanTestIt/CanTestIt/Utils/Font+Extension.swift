import UIKit
import SwiftUI

extension UIFont {
    static func font(_ style: FontStyle) -> UIFont {
        Fonts().font(style)
    }
    
    static func font(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        Fonts().font(size: size, weight: weight)
    }
}
