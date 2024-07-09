import Foundation

final class MockURLSession: URLSession {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?

    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, (any Error)?) -> Void) -> URLSessionDataTask {
        completionHandler(mockData, mockResponse, mockError)
        return URLSessionDataTask()
    }
}
