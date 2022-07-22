import SwiftUI

struct AttributedText: View {
    @State private var size: CGSize = .zero
    let attributedString: NSAttributedString
    
    init(_ attributedString: NSAttributedString) {
        self.attributedString = attributedString
    }
    
    var body: some View {
        AttributedTextRepresentable(attributedString: attributedString, size: $size)
            .frame(width: size.width, height: size.height)
    }
    
    struct AttributedTextRepresentable: UIViewRepresentable {
        let attributedString: NSAttributedString
        @Binding var size: CGSize

        func makeUIView(context: Context) -> UILabel {
            let label = UILabel()
            
            label.lineBreakMode = .byClipping
            label.numberOfLines = 0

            return label
        }
        
        func updateUIView(_ uiView: UILabel, context: Context) {
            uiView.attributedText = attributedString
            
            DispatchQueue.main.async {
                size = uiView.sizeThatFits(uiView.superview?.bounds.size ?? .zero)
            }
        }
    }
}
