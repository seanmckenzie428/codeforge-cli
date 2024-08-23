// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import Progress

@main
struct Main {

    static func main() {
        let parameters = CodeforgeParameters.promptForOptions()
        let codeforge = Codeforge(parameters)
        codeforge.run()
    }

}

public struct Codeforge {

    var parameters: CodeforgeParameters

    init(_ parameters: CodeforgeParameters) {
        self.parameters = parameters
    }

    func run() {
        print("Generating codes...")
        let codes = generateCodes(parameters)
        print("Saving codes to file(s)...")
        outputCodes(codes)
        print("Done!")
        exit(EXIT_SUCCESS)
    }

    func generateCode() -> String {
        let characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

        var code = ""
        var counter = 1
        for _ in 0..<parameters.codeLength {
            let randomCharacter = characters.randomElement()!
            code.append(randomCharacter)
            if counter == parameters.charactersBetweenDashes {
                code += "-"
                counter = 1
            } else {
                counter += 1
            }
        }
        if code.last == "-" {
            code.removeLast()
        }
        return code
    }

    func generateCodes(_ parameters: CodeforgeParameters) -> Set<String> {
        var codes: Set<String> = []

        var progressBar = ProgressBar(count: parameters.numOfCodes)

        while codes.count < parameters.numOfCodes {
            let code = generateCode()
            codes.insert(code)
            progressBar.next()
        }

        return codes
    }

    func outputCodes(_ codes: Set<String>) {
        let codesArray = Array(codes)
        let numberOfFiles = Int(ceil(Double(codes.count) / Double(parameters.codesPerFile)))

        for fileIndex in 0..<numberOfFiles {
            var data = "code\n"
            let startIndex = fileIndex * parameters.codesPerFile
            let endIndex = min(startIndex + parameters.codesPerFile, codes.count)
            for index in startIndex..<endIndex {
                data += "\(codesArray[index])\n"
            }
            let filename = "\(parameters.filename)_\(fileIndex + 1).csv"
            do {
                try data.write(toFile: filename, atomically: true, encoding: .utf8)
            } catch {
                print("Failed to write file: \(filename), error: \(error)")
                exit(EXIT_FAILURE)
            }
        }
    }


}

public struct CodeforgeParameters {
    var numOfCodes: Int
    var codeLength: Int
    var charactersBetweenDashes: Int
    var codesPerFile: Int = 1000
    var filename: String = "codes"
}

extension CodeforgeParameters {

    static func promptForOptions() -> CodeforgeParameters {
        print("Let's generate some codes!\n")

        print("How many codes would you like to generate? ")
        let numOfCodes = readInt()

        print("How long should each code be (excluding dashes)? ")
        let codeLength = readInt()

        print("How many characters between dashes? ")
        let charactersBetweenDashes = readInt()

        print("How many codes per file? ")
        let codesPerFile = readInt()

        print("What would you like to name the file(s)? Enter a name without a file extension: ")
        guard let filename = readLine() else {
            print("Please enter a valid filename")
            exit(EXIT_FAILURE)
        }

        return CodeforgeParameters(
            numOfCodes: numOfCodes,
            codeLength: codeLength,
            charactersBetweenDashes: charactersBetweenDashes,
            codesPerFile: codesPerFile,
            filename: filename
        )
    }

    static func readInt() -> Int {
        guard let input = readLine(), let number = Int(input) else {
            print("Please enter a valid number")
            exit(EXIT_FAILURE)
        }
        return number
    }

}
