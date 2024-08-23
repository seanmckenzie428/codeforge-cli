import XCTest
@testable import codeforge

final class codeforgeTests: XCTestCase {
    func testGenerateCode() {
        let parameters = CodeforgeParameters(numOfCodes: 1, codeLength: 10, charactersBetweenDashes: 100)
        let codeforge = Codeforge(parameters)
        let code = codeforge.generateCode()
        XCTAssertEqual(code.count, 10)
    }
}
