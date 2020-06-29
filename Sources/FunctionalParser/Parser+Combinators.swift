import Foundation

extension Parser {
    public static func zeroOrMore(_ p: Parser<A>, separatedBy s: Parser<Void> = .literal("")) -> Parser<[A]> {
        Parser<[A]> { str in
            var rest = str
            var matches: [A] = []
            while let match = p.run(&str) {
                rest = str
                matches.append(match)
                if s.run(&str) == nil {
                    return matches
                }
            }
            str = rest
            return matches
        }
    }
}

extension Parser {
    public static func oneOf(_ ps: [Parser<A>]) -> Parser {
        Parser<A> { str in
            for p in ps {
                if let match = p.run(&str) {
                    return match
                }
            }
            return nil
        }
    }
}

extension Parser where A == Void {
    public static func not<B>(_ p: Parser<B>) -> Parser {
        Parser { str in
            let backup = str
            if p.run(&str) != nil {
                str = backup
                return nil
            }
            return ()
        }
    }
}

extension Parser {
    public static func prefix(while repeatedParser: Parser, combine: @escaping (A, A) -> A) -> Parser {
        Parser { str in
            guard var accumulator = repeatedParser.run(&str) else { return nil }
            while let possibleA = repeatedParser.run(&str) {
                accumulator = combine(accumulator, possibleA)
            }
            return accumulator
        }
    }

    public static func prefix<B>(
        while repeatedParser: Parser<B>,
        reduce: (initial: A, transform: (inout A, B) -> Void)
    ) -> Parser {
        Parser { str in
            guard let first = repeatedParser.run(&str) else { return nil }

            var accumulator = reduce.initial
            reduce.transform(&accumulator, first)

            while let possibleB = repeatedParser.run(&str) {
                reduce.transform(&accumulator, possibleB)
            }
            return accumulator
        }
    }
}
