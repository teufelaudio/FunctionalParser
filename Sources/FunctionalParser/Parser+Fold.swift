import Foundation

extension Parser {
    public static func fold<Condition>(if condition: Parser<Condition>, then: Parser, else otherwise: Parser) -> Parser {
        Parser { str in
            let backup = str
            if condition.run(&str) != nil {
                str = backup
                return then.run(&str)
            } else {
                str = backup
                return otherwise.run(&str)
            }
        }
    }
}

extension Parser {
    public func replaceMismatch(with alternative: A) -> Parser {
        Parser { str in
            if let originalMatch = self.run(&str) {
                return originalMatch
            }
            return alternative
        }
    }

    public func catchMismatch(_ alternative: @escaping () -> Parser) -> Parser {
        Parser { str in
            if let originalMatch = self.run(&str) {
                return originalMatch
            }
            return alternative().run(&str)
        }
    }
}
