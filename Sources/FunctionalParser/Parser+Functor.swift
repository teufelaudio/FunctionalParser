import Foundation

extension Parser {
    public func map<B>(_ f: @escaping (A) -> B) -> Parser<B> {
        Parser<B> { str in
            self.run(&str).map(f)
        }
    }
}
