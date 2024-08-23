// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import SwiftPrompt

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
        Prompt.writeGroupUpdate(title: "Generating codes...")
        let codes = generateCodes(parameters)
        Prompt.writeGroupUpdate(title: "Saving codes...")
        outputCodes(codes)
        Prompt.endPromptGroup(title: "Finished generating codes!")
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
        while codes.count < parameters.numOfCodes {
            let code = generateCode()
            codes.insert(code)
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
        Prompt.startPromptGroup(title: "Let's generate some codes!")

        let numOfCodes = Prompt.textInput(
        question: "How many codes would you like to generate?",
        placeholder: nil,
        isSecureEntry: false,
        validator: self.validateNumberInput)

        let codeLength = Prompt.textInput(
        question: "How long should each code be?",
        placeholder: nil,
        isSecureEntry: false,
        validator: self.validateNumberInput)

        let charactersBetweenDashes = Prompt.textInput(
        question: "How many characters between dashes?",
        placeholder: nil,
        isSecureEntry: false,
        validator: self.validateNumberInput)

        let codesPerFile = Prompt.textInput(
        question: "How many codes would you like to save per file?",
        placeholder: nil,
        isSecureEntry: false,
        validator: self.validateNumberInput)

        let filename = Prompt.textInput(
        question: "What would you like to name the file?",
        placeholder: nil,
        isSecureEntry: false,
        validator: { input in
            return input.isEmpty ? .invalid(message: "Please enter a valid filename") : .valid
            }
        )


        return CodeforgeParameters(
            numOfCodes: Int(numOfCodes)!,
            codeLength: Int(codeLength)!,
            charactersBetweenDashes: Int(charactersBetweenDashes)!,
            codesPerFile: Int(codesPerFile)!,
            filename: filename
        )
    }

    static func validateNumberInput(_ input: String) -> ValidationResult {
        return Int(input) != nil ? .valid : .invalid(message: "Please enter a valid number")
    }
}
