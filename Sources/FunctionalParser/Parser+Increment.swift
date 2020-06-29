import Foundation

extension Parser {
    public static func incrementing(start: Int = 1, parser: @escaping (Int) -> Parser) -> Parser {
        var currentNumber = start
        return parserWithEffect(
            { parser(currentNumber) },
            onSuccess: { _ in currentNumber += 1 }
        )
    }
}
