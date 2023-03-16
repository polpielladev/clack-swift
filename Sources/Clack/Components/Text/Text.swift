import ANSITerminal

func writeAt(_ row: Int, _ col: Int, _ text: String) {
    moveTo(row, col)
    write(text)
}

public struct Validator {
    let validate: (String) -> Bool
    let failureString: String
    
    public init(validate: @escaping (String) -> Bool, failureString: String) {
        self.validate = validate
        self.failureString = failureString
    }
}

public func text(question: String, placeholder: String = "", validator: Validator? = nil, isSecureEntry: Bool = false) -> String {
    cursorOn()
    moveLineDown()
    let promptStartLine = readCursorPos().row
    write("◆".foreColor(81).bold)
    moveRight()
    write(question)
    moveLineDown()
    write(ANSIChar.activeBracketLine)
    moveLineDown()
    write(ANSIChar.activeCloser)
    
    let bottomPos = readCursorPos()
    moveLineUp()
    moveRight(2)
    let initialCursorPosition = readCursorPos()
    write(placeholder.foreColor(244))
    moveTo(initialCursorPosition.row, initialCursorPosition.col)
    
    var validationFailed = false
    
    let textInput = readTextInput(
        validate: validator?.validate ?? { _ in true },
        validationFailed: {
            validationFailed = true
            cursorOff()
            let currentPosition = readCursorPos()
            writeAt(promptStartLine, 0, ANSIChar.warn)
            updateBracketColor(fromLine: promptStartLine, toLine: bottomPos.row, withColor: 11)
            writeAt(bottomPos.row, bottomPos.col + 1, validator?.failureString ?? "")
            moveTo(currentPosition.row, currentPosition.col)
            cursorOn()
        },
        onNewCharacter: { char in
            if validationFailed {
                cursorOff()
                let currentPosition = readCursorPos()
                writeAt(promptStartLine, 0, "◆".foreColor(81).bold)
                updateBracketColor(fromLine: promptStartLine, toLine: bottomPos.row, withColor: 81)
                moveTo(bottomPos.row, bottomPos.col + 1)
                clearToEndOfLine()
                moveTo(currentPosition.row, currentPosition.col)
                cursorOn()
                validationFailed = false
            }
            write("\(isSecureEntry ? "▪" : char)")
        },
        onDelete: { row, col in moveTo(row, col); deleteChar() },
        removePlaceholder: {
            moveTo(initialCursorPosition.row, initialCursorPosition.col)
            clearToEndOfLine()
        },
        showPlaceholder:  {
            write(placeholder.foreColor(244))
            moveTo(initialCursorPosition.row, initialCursorPosition.col)
        }
    )
    
    cleanUp(startLine: promptStartLine, endLine: bottomPos.row)
    
    return textInput
}

func updateBracketColor(fromLine: Int, toLine: Int, withColor color: UInt8) {
    (fromLine + 1...toLine - 1).forEach { writeAt($0, 0, ANSIChar.bracketLineNoColour.foreColor(color)) }
    writeAt(toLine, 0, ANSIChar.closerNoColour.foreColor(color))
}

func cleanUp(startLine: Int, endLine: Int) {
    cursorOff()
    
    writeAt(startLine, 0, "✔".green)
    (startLine + 1...endLine).forEach { writeAt($0, 0, ANSIChar.bracketLine) }
    
    moveTo(endLine, 0)
    
    cursorOn()
}
