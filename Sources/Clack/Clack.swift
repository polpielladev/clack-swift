@main
struct Clack {
    private(set) var text = "Hello, World!"

    static func main() {
        print(Clack().text)
    }
}
