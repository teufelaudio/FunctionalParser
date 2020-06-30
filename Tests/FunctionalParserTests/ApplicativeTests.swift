@testable import FunctionalParser
import XCTest

final class ApplicativeTests: XCTestCase {
    let parseableOriginalString = "0123456789ABCDEF"

    // MARK: - Zip 2
    func testZip2Success() throws {
        let result = Parser.zip(.literal("01"), .literal("23")).run(parseableOriginalString)
        let match: (Void, Void)? = result.match
        let rest = result.rest
        XCTAssertNotNil(match)
        XCTAssertEqual("456789ABCDEF", String(rest))
    }

    func testZip2Fail1() throws {
        let result = Parser.zip(.literal("00"), .literal("23")).run(parseableOriginalString)
        let match: (Void, Void)? = result.match
        let rest = result.rest
        XCTAssertNil(match)
        XCTAssertEqual(parseableOriginalString, String(rest))
    }

    func testZip2Fail2() throws {
        let result = Parser.zip(.literal("01"), .literal("22")).run(parseableOriginalString)
        let match: (Void, Void)? = result.match
        let rest = result.rest
        XCTAssertNil(match)
        XCTAssertEqual(parseableOriginalString, String(rest))
    }

    // MARK: - Zip 3
    func testZip3Success() throws {
        let result = Parser.zip(.literal("01"), .literal("23"), .literal("45")).run(parseableOriginalString)
        let match: (Void, Void, Void)? = result.match
        let rest = result.rest
        XCTAssertNotNil(match)
        XCTAssertEqual("6789ABCDEF", String(rest))
    }

    func testZip3Fail1() throws {
        let result = Parser.zip(.literal("00"), .literal("23"), .literal("45")).run(parseableOriginalString)
        let match: (Void, Void, Void)? = result.match
        let rest = result.rest
        XCTAssertNil(match)
        XCTAssertEqual(parseableOriginalString, String(rest))
    }

    func testZip3Fail2() throws {
        let result = Parser.zip(.literal("01"), .literal("22"), .literal("45")).run(parseableOriginalString)
        let match: (Void, Void, Void)? = result.match
        let rest = result.rest
        XCTAssertNil(match)
        XCTAssertEqual(parseableOriginalString, String(rest))
    }

    func testZip3Fail3() throws {
        let result = Parser.zip(.literal("01"), .literal("23"), .literal("44")).run(parseableOriginalString)
        let match: (Void, Void, Void)? = result.match
        let rest = result.rest
        XCTAssertNil(match)
        XCTAssertEqual(parseableOriginalString, String(rest))
    }

    // MARK: - Zip 4
    func testZip4Success() throws {
        let result = Parser.zip(.literal("01"), .literal("23"), .literal("45"), .literal("67")).run(parseableOriginalString)
        let match: (Void, Void, Void, Void)? = result.match
        let rest = result.rest
        XCTAssertNotNil(match)
        XCTAssertEqual("89ABCDEF", String(rest))
    }

    func testZip4Fail1() throws {
        let result = Parser.zip(.literal("00"), .literal("23"), .literal("45"), .literal("67")).run(parseableOriginalString)
        let match: (Void, Void, Void, Void)? = result.match
        let rest = result.rest
        XCTAssertNil(match)
        XCTAssertEqual(parseableOriginalString, String(rest))
    }

    func testZip4Fail2() throws {
        let result = Parser.zip(.literal("01"), .literal("22"), .literal("45"), .literal("67")).run(parseableOriginalString)
        let match: (Void, Void, Void, Void)? = result.match
        let rest = result.rest
        XCTAssertNil(match)
        XCTAssertEqual(parseableOriginalString, String(rest))
    }

    func testZip4Fail3() throws {
        let result = Parser.zip(.literal("01"), .literal("23"), .literal("44"), .literal("67")).run(parseableOriginalString)
        let match: (Void, Void, Void, Void)? = result.match
        let rest = result.rest
        XCTAssertNil(match)
        XCTAssertEqual(parseableOriginalString, String(rest))
    }

    func testZip4Fail4() throws {
        let result = Parser.zip(.literal("01"), .literal("23"), .literal("45"), .literal("66")).run(parseableOriginalString)
        let match: (Void, Void, Void, Void)? = result.match
        let rest = result.rest
        XCTAssertNil(match)
        XCTAssertEqual(parseableOriginalString, String(rest))
    }

    // MARK: - Zip 5
    func testZip5Success() throws {
        let result = Parser.zip(.literal("01"), .literal("23"), .literal("45"), .literal("67"), .literal("89")).run(parseableOriginalString)
        let match: (Void, Void, Void, Void, Void)? = result.match
        let rest = result.rest
        XCTAssertNotNil(match)
        XCTAssertEqual("ABCDEF", String(rest))
    }

    func testZip5Fail1() throws {
        let result = Parser.zip(.literal("00"), .literal("23"), .literal("45"), .literal("67"), .literal("89")).run(parseableOriginalString)
        let match: (Void, Void, Void, Void, Void)? = result.match
        let rest = result.rest
        XCTAssertNil(match)
        XCTAssertEqual(parseableOriginalString, String(rest))
    }

    func testZip5Fail2() throws {
        let result = Parser.zip(.literal("01"), .literal("22"), .literal("45"), .literal("67"), .literal("89")).run(parseableOriginalString)
        let match: (Void, Void, Void, Void, Void)? = result.match
        let rest = result.rest
        XCTAssertNil(match)
        XCTAssertEqual(parseableOriginalString, String(rest))
    }

    func testZip5Fail3() throws {
        let result = Parser.zip(.literal("01"), .literal("23"), .literal("44"), .literal("67"), .literal("89")).run(parseableOriginalString)
        let match: (Void, Void, Void, Void, Void)? = result.match
        let rest = result.rest
        XCTAssertNil(match)
        XCTAssertEqual(parseableOriginalString, String(rest))
    }

    func testZip5Fail4() throws {
        let result = Parser.zip(.literal("01"), .literal("23"), .literal("45"), .literal("66"), .literal("89")).run(parseableOriginalString)
        let match: (Void, Void, Void, Void, Void)? = result.match
        let rest = result.rest
        XCTAssertNil(match)
        XCTAssertEqual(parseableOriginalString, String(rest))
    }

    func testZip5Fail5() throws {
        let result = Parser.zip(.literal("01"), .literal("23"), .literal("45"), .literal("67"), .literal("88")).run(parseableOriginalString)
        let match: (Void, Void, Void, Void, Void)? = result.match
        let rest = result.rest
        XCTAssertNil(match)
        XCTAssertEqual(parseableOriginalString, String(rest))
    }

    // MARK: - Zip 6
    func testZip6Success() throws {
        let result = Parser
            .zip(.literal("01"), .literal("23"), .literal("45"), .literal("67"), .literal("89"), .literal("AB"))
            .run(parseableOriginalString)
        let match: (Void, Void, Void, Void, Void, Void)? = result.match
        let rest = result.rest
        XCTAssertNotNil(match)
        XCTAssertEqual("CDEF", String(rest))
    }

    func testZip6Fail1() throws {
        let result = Parser
            .zip(.literal("00"), .literal("23"), .literal("45"), .literal("67"), .literal("89"), .literal("AB"))
            .run(parseableOriginalString)
        let match: (Void, Void, Void, Void, Void, Void)? = result.match
        let rest = result.rest
        XCTAssertNil(match)
        XCTAssertEqual(parseableOriginalString, String(rest))
    }

    func testZip6Fail2() throws {
        let result = Parser
            .zip(.literal("01"), .literal("22"), .literal("45"), .literal("67"), .literal("89"), .literal("AB"))
            .run(parseableOriginalString)
        let match: (Void, Void, Void, Void, Void, Void)? = result.match
        let rest = result.rest
        XCTAssertNil(match)
        XCTAssertEqual(parseableOriginalString, String(rest))
    }

    func testZip6Fail3() throws {
        let result = Parser
            .zip(.literal("01"), .literal("23"), .literal("44"), .literal("67"), .literal("89"), .literal("AB"))
            .run(parseableOriginalString)
        let match: (Void, Void, Void, Void, Void, Void)? = result.match
        let rest = result.rest
        XCTAssertNil(match)
        XCTAssertEqual(parseableOriginalString, String(rest))
    }

    func testZip6Fail4() throws {
        let result = Parser
            .zip(.literal("01"), .literal("23"), .literal("45"), .literal("66"), .literal("89"), .literal("AB"))
            .run(parseableOriginalString)
        let match: (Void, Void, Void, Void, Void, Void)? = result.match
        let rest = result.rest
        XCTAssertNil(match)
        XCTAssertEqual(parseableOriginalString, String(rest))
    }

    func testZip6Fail5() throws {
        let result = Parser
            .zip(.literal("01"), .literal("23"), .literal("45"), .literal("67"), .literal("88"), .literal("AB"))
            .run(parseableOriginalString)
        let match: (Void, Void, Void, Void, Void, Void)? = result.match
        let rest = result.rest
        XCTAssertNil(match)
        XCTAssertEqual(parseableOriginalString, String(rest))
    }

    func testZip6Fail6() throws {
        let result = Parser
            .zip(.literal("01"), .literal("23"), .literal("45"), .literal("67"), .literal("89"), .literal("AA"))
            .run(parseableOriginalString)
        let match: (Void, Void, Void, Void, Void, Void)? = result.match
        let rest = result.rest
        XCTAssertNil(match)
        XCTAssertEqual(parseableOriginalString, String(rest))
    }

    // MARK: - Zip 7
    func testZip7Success() throws {
        let result = Parser
            .zip(.literal("01"), .literal("23"), .literal("45"), .literal("67"), .literal("89"), .literal("AB"), .literal("CD"))
            .run(parseableOriginalString)
        let match: (Void, Void, Void, Void, Void, Void, Void)? = result.match
        let rest = result.rest
        XCTAssertNotNil(match)
        XCTAssertEqual("EF", String(rest))
    }

    func testZip7Fail1() throws {
        let result = Parser
            .zip(.literal("00"), .literal("23"), .literal("45"), .literal("67"), .literal("89"), .literal("AB"), .literal("CD"))
            .run(parseableOriginalString)
        let match: (Void, Void, Void, Void, Void, Void, Void)? = result.match
        let rest = result.rest
        XCTAssertNil(match)
        XCTAssertEqual(parseableOriginalString, String(rest))
    }

    func testZip7Fail2() throws {
        let result = Parser
            .zip(.literal("01"), .literal("22"), .literal("45"), .literal("67"), .literal("89"), .literal("AB"), .literal("CD"))
            .run(parseableOriginalString)
        let match: (Void, Void, Void, Void, Void, Void, Void)? = result.match
        let rest = result.rest
        XCTAssertNil(match)
        XCTAssertEqual(parseableOriginalString, String(rest))
    }

    func testZip7Fail3() throws {
        let result = Parser
            .zip(.literal("01"), .literal("23"), .literal("44"), .literal("67"), .literal("89"), .literal("AB"), .literal("CD"))
            .run(parseableOriginalString)
        let match: (Void, Void, Void, Void, Void, Void, Void)? = result.match
        let rest = result.rest
        XCTAssertNil(match)
        XCTAssertEqual(parseableOriginalString, String(rest))
    }

    func testZip7Fail4() throws {
        let result = Parser
            .zip(.literal("01"), .literal("23"), .literal("45"), .literal("66"), .literal("89"), .literal("AB"), .literal("CD"))
            .run(parseableOriginalString)
        let match: (Void, Void, Void, Void, Void, Void, Void)? = result.match
        let rest = result.rest
        XCTAssertNil(match)
        XCTAssertEqual(parseableOriginalString, String(rest))
    }

    func testZip7Fail5() throws {
        let result = Parser
            .zip(.literal("01"), .literal("23"), .literal("45"), .literal("67"), .literal("88"), .literal("AB"), .literal("CD"))
            .run(parseableOriginalString)
        let match: (Void, Void, Void, Void, Void, Void, Void)? = result.match
        let rest = result.rest
        XCTAssertNil(match)
        XCTAssertEqual(parseableOriginalString, String(rest))
    }

    func testZip7Fail6() throws {
        let result = Parser
            .zip(.literal("01"), .literal("23"), .literal("45"), .literal("67"), .literal("89"), .literal("AA"), .literal("CD"))
            .run(parseableOriginalString)
        let match: (Void, Void, Void, Void, Void, Void, Void)? = result.match
        let rest = result.rest
        XCTAssertNil(match)
        XCTAssertEqual(parseableOriginalString, String(rest))
    }

    func testZip7Fail7() throws {
        let result = Parser
            .zip(.literal("01"), .literal("23"), .literal("45"), .literal("67"), .literal("89"), .literal("AB"), .literal("CC"))
            .run(parseableOriginalString)
        let match: (Void, Void, Void, Void, Void, Void, Void)? = result.match
        let rest = result.rest
        XCTAssertNil(match)
        XCTAssertEqual(parseableOriginalString, String(rest))
    }
}
