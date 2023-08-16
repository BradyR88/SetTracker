//
//  HorizontalPicker.swift
//  SetTracker
//
//  Created by Brady Robshaw on 8/13/23.
//
// Code from https://github.com/GGJJack/SwiftUIWheelPicker/blob/master/SwiftUIWheelPicker/Classes/SwiftUIWheelPicker.swift


import SwiftUI

public enum WidthOption {
    case VisibleCount(Int)
    case Fixed(CGFloat)
    case Ratio(CGFloat)
}
//SwiftUICustomSlider
public struct HorizontalPicker<Content: View, Item>: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    
    private var items: Binding<[Item]>
    let contentBuilder: (Item) -> Content
    @Binding var position: Int
    @GestureState private var translation: CGFloat = 0
    // how far a item is spaced apart from its neighbor
    private var contentWidthOption: WidthOption {
        switch dynamicTypeSize {
        case .xSmall:
            return .Fixed(30)
        case .small:
            return .Fixed(30)
        case .medium:
            return .Fixed(35)
        case .large:
            return .Fixed(35)
        case .xLarge:
            return .Fixed(39)
        case .xxLarge:
            return .Fixed(42)
        case .xxxLarge:
            return .Fixed(45)
        case .accessibility1:
            return .Fixed(50)
        case .accessibility2:
            return .Fixed(63)
        case .accessibility3:
            return .Fixed(80)
        case .accessibility4:
            return .Fixed(90)
        case .accessibility5:
            return .Fixed(98)
        @unknown default:
            return .Fixed(35)
        }
    }
    private var contentPadingOption: CGFloat {
        switch dynamicTypeSize {
            
        case .xSmall:
            0
        case .small:
            0
        case .medium:
            0
        case .large:
            0
        case .xLarge:
            0
        case .xxLarge:
            0
        case .xxxLarge:
            0
        case .accessibility1:
            20
        case .accessibility2:
            25
        case .accessibility3:
            30
        case .accessibility4:
            35
        case .accessibility5:
            40
        @unknown default:
            0
        }
    }
    // how much the text size decreases as you move away from the center
    private var sizeFactor: CGFloat = 0.9
    // how much the text fades as you move away from the center
    private var alphaFactor: Double = 0.2
    
    public init(_ position: Binding<Int>, items: Binding<[Item]>, @ViewBuilder content: @escaping (Item) -> Content) {
        self.items = items
        self._position = position
        self.contentBuilder = content
    }
    
    public init(_ position: Binding<Int>, items: [Item], @ViewBuilder content: @escaping (Item) -> Content) {
        self.items = Binding.constant(items)
        self._position = position
        self.contentBuilder = content
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(Color.gray)
                    .opacity(0.2)
                    .frame(width: self.calcContentWidth(geometry, option: contentWidthOption))
                
                HStack(spacing: 0) {
                    ForEach(0..<items.wrappedValue.count, id: \.self) { position in
                        drawContentView(position, geometry: geometry)
                    }
                }
                .padding(.vertical, contentPadingOption)
                .frame(width: geometry.size.width, alignment: .leading)
                .offset(x: -CGFloat(self.position + 1) * self.calcContentWidth(geometry, option: contentWidthOption))
                .offset(x: self.translation + (geometry.size.width / 2) + (self.calcContentWidth(geometry, option: contentWidthOption) / 2))
                .animation(.interactiveSpring(), value: self.position + 1)
                .animation(.interactiveSpring(), value: translation)
                .clipped()
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .contentShape(Rectangle())
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.width
                }
                    .onEnded { value in
                        let offset = value.translation.width / self.calcContentWidth(geometry, option: contentWidthOption)
                        let newIndex = (CGFloat(self.position) - offset).rounded()
                        self.position = min(max(Int(newIndex), 0), self.items.wrappedValue.count - 1)
                    }
            )
        }
        .padding(.vertical, contentPadingOption)
        .sensoryFeedback(.selection, trigger: position)
    }
    
    private func drawContentView(_ position: Int, geometry: GeometryProxy) -> some View {
        let sizeResult: CGFloat
        let alphaResult: Double
        
        let maxRange = floor(maxVisible(geometry) / 2.0)
        let offset = translation / self.calcContentWidth(geometry, option: contentWidthOption)
        let newIndex = CGFloat(self.position) - offset
        let posGap = CGFloat(position) - newIndex
        var per = abs(posGap / maxRange)
        if 1.0 < per {
            per = 1.0
        }
        
        let sizeGap = 1.0 - sizeFactor
        let preSizeRst = per * sizeGap
        sizeResult = 1 - preSizeRst
        
        let alphaGap = 1.0 - alphaFactor
        let preAlphaRst = Double(per) * alphaGap
        alphaResult = 1.0 - preAlphaRst
        
        let item = items.wrappedValue[position]
        return contentBuilder(item)
            .scaleEffect(sizeResult)
            .opacity(alphaResult)
            .frame(width: self.calcContentWidth(geometry, option: contentWidthOption), alignment: .center)
    }
    
    private func maxVisible(_ geometry: GeometryProxy) -> CGFloat {
        let visibleCount = geometry.size.width / self.calcContentWidth(geometry, option: contentWidthOption)
        return min(visibleCount, CGFloat(self.items.wrappedValue.count))
    }
    
    private func calcContentWidth(_ geometry: GeometryProxy, option: WidthOption) -> CGFloat {
        switch option {
        case .VisibleCount(let count):
            return geometry.size.width / CGFloat(count)
        case .Fixed(let width):
            return width
        case .Ratio(let ratio):
            return geometry.size.width * ratio
        }
    }
}

struct SwiftUIWheelPickerView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            HorizontalPicker(Binding.constant(5), items: Binding.constant([0, 1, 2, 3, 4, 5, 6, 7, 8 ,9, 10])) { value in
                GeometryReader { reader in
                    Text("V\(value)")
                        .frame(width: reader.size.width, height: reader.size.height, alignment: .center)
                }
            }
        }
        .padding(.top, 200)
    }
}
