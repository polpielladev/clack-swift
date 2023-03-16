import Foundation
import ANSITerminal

func readTextInput(
    validate: (String) -> Bool = { _ in true },
    validationFailed: () -> Void = {},
    onNewCharacter: (Character) -> Void,
    onDelete: (Int, Int) -> Void
) -> String {
    var output = ""

    while true {
        clearBuffer()
        
        if keyPressed() {
            let char = readChar()
            if char == NonPrintableChar.enter.char() {
                if validate(output) {
                    break
                } else {
                    validationFailed()
                }
            } else if char == NonPrintableChar.del.char() {
                let cursorPosition = readCursorPos()
                if output.count > 0 {
                    onDelete(cursorPosition.row, cursorPosition.col - 1)
                    _ = output.removeLast()
                }
            }
            
            if !isNonPrintable(char: char) {
                onNewCharacter(char)
                output.append(char)
            }
        }
    }
    
    return output
}
