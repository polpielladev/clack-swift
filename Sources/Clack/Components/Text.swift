import ANSITerminal

func writeAt(_ row: Int, _ col: Int, _ text: String) {
    moveTo(row, col)
    write(text)
}

public func text(question: String, isSecureEntry: Bool = false) -> String {
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
    
    if isSecureEntry {
        while true {
            clearBuffer()
            
            if keyPressed() {
                let char = readChar()
                if char == NonPrintableChar.enter.char() {
                    break
                } else if char == NonPrintableChar.del.char() {
                    let cursorPosition = readCursorPos()
                    if cursorPosition.col > 3 {
                        moveTo(cursorPosition.row, cursorPosition.col - 1)
                        deleteChar()
                    }
                }
                
                if !isNonPrintable(char: char) {
                    write("▪")
                }
            }
        }
        
        cleanUp(startLine: promptStartLine, endLine: bottomPos.row)
        
        return ""
    } else {
        let answer = ask("")
        
        cleanUp(startLine: promptStartLine, endLine: bottomPos.row)
        
        return answer
    }
}

func cleanUp(startLine: Int, endLine: Int) {
    cursorOff()
    
    writeAt(startLine, 0, "✔".green)
    (startLine + 1...endLine).forEach { writeAt($0, 0, ANSIChar.bracketLine) }
    
    moveTo(endLine, 0)
    
    cursorOn()
}
