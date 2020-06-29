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
