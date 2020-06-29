import Foundation

extension Parser where A == String {
    public static func string<Condition>(until condition: Parser<Condition>) -> Parser {

        return prefix(
            while: Parser<Character>.fold(
                if: condition,
                then: Parser<Character>.never,
                else: Parser<Character>.next
            ),
            reduce: (
                initial: "",
                transform: { (accumulator: inout String, char: Character) -> Void in
                    accumulator.append(char)
                }
            )
        )
    }
}

extension Parser where A == Void {
    public static func literal(_ literal: String) -> Parser {
        Parser { str in
            guard str.hasPrefix(literal) else { return nil }
            let newStart = str.index(str.startIndex, offsetBy: literal.count)
            str = str[newStart ..< str.endIndex]
            return ()
        }
    }
}

extension Parser where A == Character {
    public static let next = Parser { str in
        guard let first = str.first else { return nil }
        let newStart = str.index(str.startIndex, offsetBy: 1)
        str = str[newStart ..< str.endIndex]
        return first
    }

    public static func next(if condition: @escaping (Character) -> Bool) -> Parser<Character> {
        Parser { str in
            guard !str.isEmpty else { return nil }
            let backup = str
            guard let next = Parser<Character>.next.run(&str) else { return nil }

            if condition(next) {
                return next
            } else {
                str = backup
                return nil
            }
        }
    }
}

extension Parser where A == Void {
    public static let zeroOrMoreSpaces = Parser<Substring>.prefix(while: { $0.isWhitespace && !$0.isNewline }).map { _ in () }

    public static let oneOrMoreSpaces = Parser<Substring>
        .prefix(while: {
            $0.isWhitespace && !$0.isNewline
        }).flatMap { $0.isEmpty ? .never : .always(()) }

    public static let zeroOrMoreSpacesOrLines = Parser<Substring>.prefix(while: { $0.isWhitespace }).map { _ in () }

    public static let oneOrMoreLineBreaks = Parser<Substring>.prefix(while: { $0.isNewline }).flatMap { $0.isEmpty ? .never : .always(()) }
}

extension Parser where A == Void {
    public static let lineBreak = Parser<Character>.next(if: { $0.isNewline }).map { _ in }
}

extension Parser where A == Substring {
    public static func prefix(while condition: @escaping (Character) -> Bool) -> Parser<Substring> {
        Parser { str in
            let prefix = str.prefix(while: condition)
            guard !prefix.isEmpty else { return prefix }

            let newStart = str.index(str.startIndex, offsetBy: prefix.count)
            str = str[newStart ..< str.endIndex]

            return prefix
        }
    }
}
