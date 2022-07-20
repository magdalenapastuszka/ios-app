import UIKit

final class Fonts {
    func font(_ style: FontStyle) -> UIFont {
        .preferredFont(forTextStyle: textStyle(for: style))
    }

    func font(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        .systemFont(ofSize: size, weight: weight)
    }

    private func textStyle(for style: FontStyle) -> UIFont.TextStyle {
        switch style {
        case .caption1:
            return .caption1
        case .caption2:
            return .caption2
        case .footnote:
            return .footnote
        case .subheadline:
            return .subheadline
        case .callout:
            return .callout
        case .body:
            return .body
        case .headline:
            return .headline
        case .title3:
            return .title3
        case .title2:
            return .title2
        case .title1:
            return .title1
        case .largeTitle:
            return .largeTitle
        }
    }
}
