import XCTest
@testable import codeforge

final class codeforgeTests: XCTestCase {
    func testGenerateCode() {
        let parameters = CodeforgeParameters(numOfCodes: 1, codeLength: 10, charactersBetweenDashes: 100)
        let codeforge = Codeforge(parameters)
        let code = codeforge.generateCode()
        XCTAssertEqual(code.count, 10)
    }

    func testGenerateCodeWithDashes() {
        let parameters = CodeforgeParameters(numOfCodes: 1, codeLength: 15, charactersBetweenDashes: 5)
        let codeforge = Codeforge(parameters)
        let code = codeforge.generateCode()
        let chunks = code.split(separator: "-")

        XCTAssertEqual(chunks.count, 3)
        XCTAssertEqual(chunks[0].count, 5)
    }

    func testGenerateCodes() {
        let parameters = CodeforgeParameters(numOfCodes: 10, codeLength: 10, charactersBetweenDashes: 100)
        let codeforge = Codeforge(parameters)
        let codes = codeforge.generateCodes(parameters)
        XCTAssertEqual(codes.count, 10)
    }
}
