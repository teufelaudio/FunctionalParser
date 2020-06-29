import Foundation

public struct Parser<A> {
    public let run: (inout Substring) -> A?

    public func run(_ str: String) -> (match: A?, rest: Substring) {
        var str = str[...]
        let match = self.run(&str)
        return (match, str)
    }
}
