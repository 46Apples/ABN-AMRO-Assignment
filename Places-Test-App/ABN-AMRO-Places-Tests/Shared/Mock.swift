// Use [Mock] to inject a stubbed result for a unit test.
// [T] is the data type to be returned in the [Success] parameter of the [Result] type.
// [U] is a subclass of the [MockStub] type that [Mock] will instantiate with the stubbed data.
class Mock<T, U: MockStub<T>>: MockStub<T> {
    static func stubbed(result: Result<T, Error>) -> U {
        .init(with: result)
    }
}
