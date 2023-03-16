import ANSITerminal

enum ANSIChar {
    static let activeBracketLine = "│".foreColor(81)
    static let bracketLine = "│".foreColor(252)
    static let bracketLineNoColour = "│"
    static let opener = "┌".foreColor(252)
    static let closer = "└".foreColor(252)
    static let closerNoColour = "└"
    static let activeCloser = "└".foreColor(81)
    static let warn = "▲".yellow
}
