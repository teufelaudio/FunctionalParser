@testable import FunctionalParser
import XCTest

final class OneOfTests: XCTestCase {
    let parseableOriginalString = "0123456789ABCDEF"

    func testOneOfEmptyFails() throws {
        let sut = Parser<Void>.oneOf([])

        let result = sut.run(parseableOriginalString)

        XCTAssertNil(result.match)
        XCTAssertEqual("0123456789ABCDEF", String(result.rest))
    }

    func testOneOfSuccess1() throws {
        let sut = Parser.oneOf([.literal("01"), .literal("02"), .literal("00")])

        let result = sut.run(parseableOriginalString)

        XCTAssertNotNil(result.match)
        XCTAssertEqual("23456789ABCDEF", String(result.rest))
    }

    func testOneOfSuccess2() throws {
        let sut = Parser.oneOf([.literal("00"), .literal("01"), .literal("02")])

        let result = sut.run(parseableOriginalString)

        XCTAssertNotNil(result.match)
        XCTAssertEqual("23456789ABCDEF", String(result.rest))
    }

    func testOneOfSuccess3() throws {
        let sut = Parser.oneOf([.literal("00"), .literal("02"), .literal("01")])

        let result = sut.run(parseableOriginalString)

        XCTAssertNotNil(result.match)
        XCTAssertEqual("23456789ABCDEF", String(result.rest))
    }

    func testOneOfFirstSuccessIsShorter() throws {
        let sut = Parser.oneOf([.literal("00"), .literal("012"), .literal("012345")])

        let result = sut.run(parseableOriginalString)

        XCTAssertNotNil(result.match)
        XCTAssertEqual("3456789ABCDEF", String(result.rest))
    }

    func testOneOfFirstSuccessIsLonger() throws {
        let sut = Parser.oneOf([.literal("00"), .literal("012345"), .literal("012")])

        let result = sut.run(parseableOriginalString)

        XCTAssertNotNil(result.match)
        XCTAssertEqual("6789ABCDEF", String(result.rest))
    }
}
