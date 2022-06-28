import SwiftUI

struct ExpandableText: View {
    @State private var expanded: Bool = false
    @State private var truncated: Bool = false
    @State private var shrinkText: String
    private var text: String
    let font: UIFont
    let lineLimit: Int
    private var moreLessText: String {
        if !truncated {
            return ""
        } else {
            return self.expanded ? " Less" : " ... More"
        }
    }
    
    init(_ text: String, lineLimit: Int, font: UIFont = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2)) {
        self.text = text
        self.lineLimit = lineLimit
        _shrinkText =  State(wrappedValue: text)
        self.font = font
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Group {
                    Text(self.expanded ? text : shrinkText)
                    + Text(moreLessText)
                        .bold()
                        .foregroundColor(.blue)
            }
            .lineLimit(expanded ? nil : lineLimit)
            .background(
                Text(text).lineLimit(lineLimit)
                    .background(GeometryReader { visibleTextGeometry in
                        Color.clear.onAppear() {
                            let size = CGSize(width: visibleTextGeometry.size.width, height: .greatestFiniteMagnitude)
                            let attributes:[NSAttributedString.Key : Any] = [NSAttributedString.Key.font : font]
                            var low  = 0
                            var high = shrinkText.count
                            var mid = high
                            while ((high - low) > 1) {
                                let attributedText = NSAttributedString(string: shrinkText + moreLessText, attributes: attributes)
                                let boundingRect = attributedText.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
                                if boundingRect.size.height > visibleTextGeometry.size.height {
                                    truncated = true
                                    high = mid
                                    mid = (high + low) / 2
                                    
                                } else {
                                    if mid == text.count {
                                        break
                                    } else {
                                        low = mid
                                        mid = (low + high) / 2
                                    }
                                }
                                shrinkText = String(text.prefix(mid))
                            }
                            if truncated {
                                shrinkText = String(shrinkText.prefix(shrinkText.count - 2))
                            }
                        }
                    })
                    .hidden()
            )
            .font(Font(font))
            if truncated {
                Button(action: {
                    expanded.toggle()
                }, label: {
                    HStack {
                        Spacer()
                        Text("")
                    }.opacity(0)
                })
            }
        }
    }
}
