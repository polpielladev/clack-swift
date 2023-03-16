import Clack

let output = text(
    question: "Hello, what's your name?",
    validator: .init(validate: { $0.lowercased() == "pol" }, failureString: "🤔 Wait... you're not Pol!")
)

let password = text(
    question: "Okay Pol, what's your password?",
    validator: .init(validate: { $0.count > 8 }, failureString: "🔐 The password needs to be at least 8 characters long"),
    isSecureEntry: true
)
