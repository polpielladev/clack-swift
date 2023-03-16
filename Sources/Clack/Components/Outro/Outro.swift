import ANSITerminal

public func outro(text: String) {
    cursorOff()
    moveDown()
    moveLeft()
    write(ANSIChar.closer)
    moveRight()
    write(text)
    moveLineDown()
    cursorOn()
}
