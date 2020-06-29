import Foundation

extension Parser {
    public static func parserWithEffect(
        _ a: @escaping () -> Parser<A>,
        onSuccess: @escaping (A) -> Void,
        onFailure: @escaping () -> Void = { }
    ) -> Parser {
        Parser { str in
            if let match = a().run(&str) {
                onSuccess(match)
                return match
            } else {
                onFailure()
                return nil
            }
        }
    }
}
