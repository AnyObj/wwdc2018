import UIKit


///Tags used to identify view components.
public enum Tags: Int {
    case tRex = 1
    case macBook = 2
    case clairvoyant = 3
    case mark = 0
    case arc1 = -1
    case arc2 = -2
    case arc3 = -3
    case other = -10
}


public extension Int {
    /// Random value generation between bounds
    public static func random(lower: Int = 0, _ upper: Int = 100) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
}

public extension Double {
    /// Random value generation between bounds
    public static func random(lower: Double = 0, _ upper: Double = 100) -> Double {
        return (Double(arc4random()) / 0xFFFFFFFF) * (upper - lower) + lower
    }
}

public extension Float {
    /// Random value generation between bounds
    public static func random(lower: Float = 0, _ upper: Float = 100) -> Float {
        return (Float(arc4random()) / 0xFFFFFFFF) * (upper - lower) + lower
    }
}

public extension CGFloat {
    /// Random value generation between bounds
    public static func random(lower: CGFloat = 0, _ upper: CGFloat = 1) -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * (upper - lower) + lower
    }
}


