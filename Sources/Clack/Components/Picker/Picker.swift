import ANSITerminal

public struct Selectable<Type> {
    let title: String
    let value: Type
    
    public init(title: String, value: Type) {
        self.title = title
        self.value = value
    }
}

public func select<Type>(title: String, options: [Selectable<Type>]) -> Type {
    cursorOff()
    moveLineDown()
    write("◆".foreColor(81).bold)
    moveRight()
    write(title)
    
    let currentLine = readCursorPos().row + 1
    let state = OptionState(
        options: options.enumerated().map { Option(title: $1.title, value: $1.value, line: currentLine + $0) },
        activeLine: currentLine,
        rangeOfLines: (currentLine, currentLine + options.count - 1)
    )

    options.forEach { selectable in
        moveLineDown()
        let isActive = readCursorPos().row == state.activeLine

        write(ANSIChar.activeBracketLine)
        moveRight()
        if isActive {
            write("●".lightGreen)
        } else {
            write("○".foreColor(250))
        }
        moveRight()
        
        if isActive {
            write(selectable.title)
        } else {
            write(selectable.title.foreColor(250))
        }
    }
    
    
    // Close...
    moveLineDown()
    let bottomLine = readCursorPos().row
    write("└".foreColor(81))

    let reRender = {
        (state.rangeOfLines.minimum...state.rangeOfLines.maximum).forEach { line in
            let isActive = line == state.activeLine
            // Update state indicator colour
            let stateIndicator = isActive ? "●".lightGreen : "○".foreColor(250)
            writeAt(line, 3, stateIndicator)

            // Update picker option title...
            if let title = state.options.first(where: { $0.line == line })?.title {
                let title = isActive ? title : title.foreColor(250)
                writeAt(line, 5, title)
            }
        }
    }

    while true {
        clearBuffer()

        if keyPressed() {
            let char = readChar()
            if char == NonPrintableChar.enter.char() {
                break
            }

            let key = readKey()
            if key.code == .up {
                if state.activeLine > state.rangeOfLines.minimum {
                    state.activeLine -= 1

                    reRender()
                }
            } else if key.code == .down {
                if state.activeLine < state.rangeOfLines.maximum {
                    state.activeLine += 1

                    reRender()
                }
            }
        }
    }

    cleanUp(startLine: currentLine - 1, endLine: bottomLine)

    return state.options.first(where: { $0.line == state.activeLine })!.value
}
