import Testing

@testable import codeforge

@Test("Generate Single Code")
func generateCode() {
    let codeLength = 15
    let numOfCodes = 1
    let charactersBetweenDashes = 5
    let params = CodeforgeParameters(
        numOfCodes: numOfCodes, codeLength: codeLength,
        charactersBetweenDashes: charactersBetweenDashes
    )
    let forge = Codeforge(params)
    let code = forge.generateCode()
    let codeChunks = code.split(separator: "-")

    #expect(codeChunks.count == codeLength / charactersBetweenDashes)
    #expect(codeChunks[0].count == charactersBetweenDashes)
}

@Test("Generate Multiple Codes")
func generateCodes() {
    let params = CodeforgeParameters(
        numOfCodes: 10, codeLength: 15, charactersBetweenDashes: 5
    )
    let forge = Codeforge(params)
    let codes = forge.generateCodes(params)

    #expect(codes.count == 10)
}
