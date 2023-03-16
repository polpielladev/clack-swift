class OptionState<Type>{
    let options: [Option<Type>]
    let rangeOfLines: (minimum: Int, maximum: Int)
    var activeLine: Int = .zero
    
    init(options: [Option<Type>], activeLine: Int, rangeOfLines: (minimum: Int, maximum: Int)) {
        self.activeLine = activeLine
        self.rangeOfLines = rangeOfLines
        self.options = options
    }
}
