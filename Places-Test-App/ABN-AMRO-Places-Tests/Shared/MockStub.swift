// [MockStub] is a wrapper that is initialized with a given [Result] type, and allows subclass mocks to be able to return the [Result] for a given unit test, either the data for [Success], or the error specified for [Failure].
class MockStub<T: Any> {
    private(set) var stubbedResult: Result<T, Error>?
    
    required init(with result: Result<T, Error>) {
        self.stubbedResult = result
    }
    
    func reset() {
        stubbedResult = nil
    }
}
