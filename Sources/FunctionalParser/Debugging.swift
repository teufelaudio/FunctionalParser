import Foundation

extension Parser {
    #if DEBUG
    public func performance(_ prefix: String = "", indent: Int = 0) -> Parser {
        Parser { str in
            let start = Date()
            let result = self.run(&str)
            let end = Date()
            print(
                "\(Array(repeating: " ", count: indent).joined())\(prefix.isEmpty ? "" : prefix + " ")\(DateInterval(start: start, end: end).duration)s"
            )
            return result
        }
    }
    #else
    public func performance(_ prefix: String = "", indent: Int = 0) -> Parser { self }
    #endif

    #if DEBUG
    public func debug(_ prefix: String = "", printMatch: Bool = false, printRemaining: Bool = false) -> Parser {
        Parser { str in
            print("\(prefix)[DEBUG] Running Parser")
            if let match = self.run(&str) {
                print("\(prefix)[DEBUG] Matched Parser")
                if printMatch { print("\(prefix)[DEBUG] Matched value: \(match)") }
                if printRemaining { print("\(prefix)[DEBUG] Remaining string: \(str)") }
                return match
            } else {
                print("\(prefix)[DEBUG] Couldn't Match Parser")
                return nil
            }
        }
    }
    #else
    public func debug(_ prefix: String = "", printMatch: Bool = false, printRemaining: Bool = false) -> Parser { self }
    #endif
}
