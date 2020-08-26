import Foundation

public enum Dots: String, CaseIterable {
    case one, two, three, four, five, six
    
    public var name: String { rawValue }
}

public struct Dice {
    public var dots: Dots
    
    public init(dots: Dots) {
        self.dots = dots
    }
    
    public mutating func roll() {
        dots = Dots.allCases.randomElement()!
    }
}
