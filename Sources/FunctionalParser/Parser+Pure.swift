import Foundation

extension Parser {
    public static var never: Parser {
        Parser { _ in nil }
    }

    public static func always(_ a: A) -> Parser {
        Parser { _ in a }
    }
}
