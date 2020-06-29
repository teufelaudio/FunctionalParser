@testable import FunctionalParser
import XCTest

final class EffectTests: XCTestCase {
    let parseableOriginalString = "0123456789ABCDEF"

    func testEffectSuccess() {
        let shouldRunBlock = expectation(description: "should have executed callback")
        let result =
            Parser.parserWithEffect(
                { Parser.literal("0123") },
                onSuccess: {
                    shouldRunBlock.fulfill()
                },
                onFailure: {
                    XCTFail("should not have executed callback")
                }
            )

            .run(parseableOriginalString)

        wait(for: [shouldRunBlock], timeout: 0.1)
        let match: (Void)? = result.match
        let rest = result.rest
        XCTAssertNotNil(match)
        XCTAssertEqual("456789ABCDEF", String(rest))
    }

    func testEffectFailure() {
        let shouldRunBlock = expectation(description: "should have executed callback")
        let result =
            Parser.parserWithEffect(
                { Parser.literal("0122") },
                onSuccess: {
                    XCTFail("should not have executed callback")
                },
                onFailure: {
                    shouldRunBlock.fulfill()
                }
            )

            .run(parseableOriginalString)

        wait(for: [shouldRunBlock], timeout: 0.1)
        let match: (Void)? = result.match
        let rest = result.rest
        XCTAssertNil(match)
        XCTAssertEqual(parseableOriginalString, String(rest))
    }

    func testEffectSuccessNoCatch() {
        let shouldRunBlock = expectation(description: "should have executed callback")
        let result =
            Parser.parserWithEffect(
                { Parser.literal("0123") },
                onSuccess: {
                    shouldRunBlock.fulfill()
                }
            )

            .run(parseableOriginalString)

        wait(for: [shouldRunBlock], timeout: 0.1)
        let match: (Void)? = result.match
        let rest = result.rest
        XCTAssertNotNil(match)
        XCTAssertEqual("456789ABCDEF", String(rest))
    }

    func testEffectFailureNoCatch() {
        let result =
            Parser.parserWithEffect(
                { Parser.literal("0122") },
                onSuccess: {
                    XCTFail("should not have executed callback")
                }
            )

            .run(parseableOriginalString)

        let match: (Void)? = result.match
        let rest = result.rest
        XCTAssertNil(match)
        XCTAssertEqual(parseableOriginalString, String(rest))
    }

}
