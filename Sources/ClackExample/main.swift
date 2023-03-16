import Clack

intro(title: "This is an intro component!")

let output = text(
    question: "Hello, what's your name?",
    placeholder: "Enter your name",
    validator: .init(validate: { $0.lowercased() == "pol" }, failureString: "🤔 Wait... you're not Pol!")
)

let password = text(
    question: "Okay Pol, what's your password?",
    placeholder: "Password must be at least 8 characters long",
    validator: .init(validate: { $0.count > 8 }, failureString: "🔐 The password needs to be at least 8 characters long"),
    isSecureEntry: true
)

enum Food {
    case banana
    case raspberry
}

let option = select(title: "Pick a fruit!", options: [Selectable(title: "🍌 Banana", value: Food.banana), Selectable(title: "🫐 Blueberry", value: .raspberry)])

outro(text: "This is an outro component!")
