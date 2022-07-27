import UIKit

extension UIColor {
    convenience init(hex: Int, withAlpha: CGFloat = 1) {
        self.init(red: ((hex & 0xFF0000) >> 16).cgFloat / 255.0,
                  green: ((hex & 0x00FF00) >> 8).cgFloat / 255.0,
                  blue: ((hex & 0x0000FF) >> 0).cgFloat / 255.0,
                  alpha: withAlpha)
    }

    convenience init(hex: String, withAlpha: CGFloat = 1) {
        let trimmedHex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)

        var rgbValue: UInt64 = 0
        Scanner(string: trimmedHex).scanHexInt64(&rgbValue)

        self.init(hex: rgbValue.integer, withAlpha: withAlpha)
    }

    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        getRed(&r, green: &g, blue: &b, alpha: &a)

        return (r, g, b, a)
    }

    func lighter(_ amount: CGFloat = 0.25) -> UIColor {
        hueColorWithBrightnessAmount(1 + amount)
    }

    func darker(_ amount: CGFloat = 0.25) -> UIColor {
        hueColorWithBrightnessAmount(1 - amount)
    }

    private func hueColorWithBrightnessAmount(_ amount: CGFloat) -> UIColor {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0

        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor(hue: hue,
                           saturation: saturation,
                           brightness: brightness * amount,
                           alpha: alpha)
        } else {
            return self
        }
    }

    var hexString: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        getRed(&r, green: &g, blue: &b, alpha: &a)

        let rgb = zip([r, g, b], [16, 8, 0])
            .map { ($0.0 * 255).integer << $0.1 }
            .reduce(0, |)

        return NSString(format: "#%06x", rgb) as String
    }
}

private extension Int {

    var cgFloat: CGFloat { CGFloat(self) }
}

private extension CGFloat {

    var integer: Int { Int(self) }
}

private extension UInt64 {

    var integer: Int { Int(self) }
}
