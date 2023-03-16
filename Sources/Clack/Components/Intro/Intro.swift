import ANSITerminal

public func intro(title: String) {
    write(ANSIChar.opener)
    moveRight()
    write(" \(title) ".backColor(81))
    moveLineDown()
    write(ANSIChar.bracketLine)
}
