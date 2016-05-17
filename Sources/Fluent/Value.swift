public protocol Value: CustomStringConvertible, Polymorphic {
    var structuredData: StructuredData { get }
}

public protocol Polymorphic {
    var int: Int? { get }
    var string: String? { get }
    var double: Double? { get }

    var fuzzyString: String? { get }
}

public enum StructuredData {
    case null
    case bool(Bool)
    case integer(Int)
    case double(Double)
    case string(String)
    case array([StructuredData])
    case dictionary([String: StructuredData])
}

extension Value {
    public var fuzzyString: String? {
        switch structuredData {
        case .bool(let bool):
            return "\(bool)"
        case .integer(let int):
            return "\(int)"
        case .double(let double):
            return "\(double)"
        case .string(let string):
            return "\(string)"
        default:
            return nil
        }
    }


    public var int: Int? {
        if case .integer(let int) = structuredData {
            return int
        }
        return nil
    }

    public var string: String? {
        if case .string(let string) = structuredData {
            return string
        }
        return nil
    }

    public var double: Double? {
        if case .double(let double) = structuredData {
            return double
        }
        return nil
    }
}

extension Value {
    public var description: String {
        return "\(self)"
    }
}

extension Int: Value {
    public var structuredData: StructuredData {
        return .integer(self)
    }
}

extension Double: Value {
    public var structuredData: StructuredData {
        return .double(self)
    }
}

extension String: Value {
    public var structuredData: StructuredData {
        return .string(self)
    }
}

extension Bool: Value {
    public var structuredData: StructuredData {
        return .bool(self)
    }
}
