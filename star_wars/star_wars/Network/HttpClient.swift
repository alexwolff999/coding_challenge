import Foundation

class HttpClient {
    static public func sendRequest<T: Decodable>(request: Request, responseModel: T.Type) async -> Result<T, Error> {
        guard let url = URL(string: request.path) else {
            return .failure(ServiceError.invalidUrl)
        }

        let urlRequest = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard (response as? HTTPURLResponse)?.statusCode == ServerResponseCode.success.rawValue else {
                return .failure(ServiceError.invalidResponse)
            }

            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedResponse)

        } catch {
            return .failure(ServiceError.invalidResponse)
        }
    }
}
