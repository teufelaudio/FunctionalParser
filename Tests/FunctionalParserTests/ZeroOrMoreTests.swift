@testable import FunctionalParser
import XCTest

final class ZeroOrMoreTests: XCTestCase {
    let parseableOriginalString = "0123456789ABCDEF"

    func testZeroOrMoreFoundZero() {
        let sut = Parser
            .zeroOrMore(
                Parser.next(if: { $0 != "0" })
            )

        let result = sut.run(parseableOriginalString)

        XCTAssertNotNil(result.match)
        XCTAssertEqual([], result.match)
        XCTAssertEqual(parseableOriginalString, String(result.rest))
    }

    func testZeroOrMoreFoundOne() {
        let sut = Parser
            .zeroOrMore(
                Parser.next(if: { $0 != "1" })
            )

        let result = sut.run(parseableOriginalString)

        XCTAssertNotNil(result.match)
        XCTAssertEqual(["0"], result.match)
        XCTAssertEqual("123456789ABCDEF", String(result.rest))
    }

    func testZeroOrMoreFoundMany() {
        let sut = Parser
            .zeroOrMore(
                Parser.next(if: { $0 != "5" })
            )

        let result = sut.run(parseableOriginalString)

        XCTAssertNotNil(result.match)
        XCTAssertEqual(["0", "1", "2", "3", "4"], result.match)
        XCTAssertEqual("56789ABCDEF", String(result.rest))
    }

    func testZeroOrMoreFoundZeroSeparatedByComma() {
        let parseableOriginalStringSeparatedByComma = "0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F"

        let sut = Parser
            .zeroOrMore(
                Parser.next(if: { $0 != "0" }),
                separatedBy: .literal(",")
            )

        let result = sut.run(parseableOriginalStringSeparatedByComma)

        XCTAssertNotNil(result.match)
        XCTAssertEqual([], result.match)
        XCTAssertEqual(parseableOriginalStringSeparatedByComma, String(result.rest))
    }

    func testZeroOrMoreFoundOneSeparatedByComma() {
        let parseableOriginalStringSeparatedByComma = "0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F"

        let sut = Parser
            .zeroOrMore(
                Parser.next(if: { $0 != "1" }),
                separatedBy: .literal(",")
            )

        let result = sut.run(parseableOriginalStringSeparatedByComma)

        XCTAssertNotNil(result.match)
        XCTAssertEqual(["0"], result.match)
        XCTAssertEqual(",1,2,3,4,5,6,7,8,9,A,B,C,D,E,F", String(result.rest))
    }

    func testZeroOrMoreFoundManySeparatedByComma() {
        let parseableOriginalStringSeparatedByComma = "0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F"

        let sut = Parser
            .zeroOrMore(
                Parser.next(if: { $0 != "5" }),
                separatedBy: .literal(",")
            )

        let result = sut.run(parseableOriginalStringSeparatedByComma)

        XCTAssertNotNil(result.match)
        XCTAssertEqual(["0", "1", "2", "3", "4"], result.match)
        XCTAssertEqual(",5,6,7,8,9,A,B,C,D,E,F", String(result.rest))
    }

    func testZeroOrMoreFoundManySeparatedByCommaButStopsDueToLackOfComma() {
        let parseableOriginalStringSeparatedByComma = "0,1,2,3 4,5,6,7,8,9,A,B,C,D,E,F"

        let sut = Parser
            .zeroOrMore(
                Parser.next(if: { $0 != "5" }),
                separatedBy: .literal(",")
            )

        let result = sut.run(parseableOriginalStringSeparatedByComma)

        XCTAssertNotNil(result.match)
        XCTAssertEqual(["0", "1", "2", "3"], result.match)
        XCTAssertEqual(" 4,5,6,7,8,9,A,B,C,D,E,F", String(result.rest))
    }
}
