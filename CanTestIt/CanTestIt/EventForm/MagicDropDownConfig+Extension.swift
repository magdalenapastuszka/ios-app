import Foundation
import UIMagicDropDown

extension MagicDropDownConfig {
    static var category: MagicDropDownConfig {
        var theme = MagicDropDownConfig()
        
        var colors = MagicDropDownConfig.Colors()
        colors.accessoryTintColor = .placeholderColor
        colors.borderColor = .textFieldBackgroundColor
        colors.hintTextColor = .placeholderColor
        colors.dropDownBoxBackgroundColor = .textFieldBackgroundColor
        colors.dropDownTableBackgroundColor = .textFieldBackgroundColor
        colors.separatorTintColor = .placeholderColor
        colors.itemSelectedColor = .textFieldBackgroundColor
        colors.itemUnselectedColor = .textFieldBackgroundColor
        colors.itemSelectedTextColor = .textColor
        colors.itemUnselectedTextColor = .placeholderColor
        colors.tableBorderColor = .textFieldBackgroundColor
        
        var fonts = MagicDropDownConfig.Fonts()
        fonts.itemFont = .font(.callout)
        fonts.hintFont = .font(.callout)
        
        var layers = MagicDropDownConfig.Layers()
        layers.boxCornerRadius = .defaultCornerRadius
        layers.tableCornerRadius = .defaultCornerRadius
        
        var texts = MagicDropDownConfig.Texts()
        texts.boxTextAlignment = .left
        texts.tableTextAlignmrnt = .left
        
        theme.colors = colors
        theme.fonts = fonts
        theme.layers = layers
        theme.texts = texts
        return theme
    }
}
