import Foundation

protocol Randomizable {
    associatedtype Element
    
    func getRandomElement(completion: @escaping (Result<Element, Error>) -> Void)
}

//Film
class NetworkMovie {
    static let shared = NetworkMovie()
    private init() {}
    
    private let url = "https://api.themoviedb.org/3/movie/popular?language=ru-US&page=1"
    private let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjMTkxNzVmYWYwOGJkNjk5YTQyNDcxZjkwMjExOTVlNiIsInN1YiI6IjY1OGQ1NDdiZmU2YzE4NmIwZGE2YTE3NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Iu3dJeNSg5MJ6NG1vsDhaqx60-zDm_qnC4zeSs2xWM4"


    func fetchMovieTitles(completion: @escaping (Result<[String], Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }

            if let data = data {
                do {
                    let cartoonCharacters = try JSONDecoder().decode(MovieResponse.self, from: data)
                    let movieTitles = cartoonCharacters.results.map { $0.title }
                    completion(.success(movieTitles))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func getRandomElement(completion: @escaping (Result<String, Error>) -> Void) {
        fetchMovieTitles { result in
            switch result {
            case .success(let titles):
                if let randomTitle = titles.randomElement() {
                    completion(.success(randomTitle))
                } else {
                    let error = NSError(domain: "YourDomain", code: 404, userInfo: [NSLocalizedDescriptionKey: "No movie titles available"])
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


//Russian Term
class RussianеTerm{
    static let shared = RussianеTerm()
    private init() {}
    
    private let russianArray = ["watch", "eye", "Inversion", "pun", "Comparison", "offer"]
    
    private lazy var url: String = {
        guard let randomWord = getRandomWord(from: russianArray) else {
            return ""
        }
        return "https://dictionary.yandex.net/api/v1/dicservice.json/lookup?key=dict.1.1.20240108T085249Z.1971ee81391a276a.acd6cd3ef69610772d93163cfa1139ce81aa5048&lang=en-ru&text=\(randomWord)"
    }()
    
    private func getRandomWord(from words: [String]) -> String? {
        guard !words.isEmpty else {
            return nil
        }

        let randomIndex = Int.random(in: 0..<words.count)
        return words[randomIndex]
    }
    
    func printRandomDefinition() {
        if let jsonData = fetchDataFromURL() {
            do {
                let response = try JSONDecoder().decode(RussianTermResponce.self, from: jsonData)
                
                if let randomDefinition = getRandomDefinition(from: response) {
                    print(randomDefinition)
                }
            } catch {
                print("Error decoding JSON:", error)
            }
        }
    }
    
    func getRandomElement(completion: @escaping (Result<String, Error>) -> Void) {
        printRandomDefinition()
    }
    
    private func getRandomDefinition(from response: RussianTermResponce) -> String? {
        let allDefinitions = response.def.flatMap { $0.tr.map { $0.text } }
        return getRandomWord(from: allDefinitions)
    }
    
    private func fetchDataFromURL() -> Data? {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return nil
        }

        do {
            return try Data(contentsOf: url)
        } catch {
            print("Error fetching data from URL:", error)
            return nil
        }
    }
}


class AnimeTitle {
    static let shared = AnimeTitle()
    private init() {}

    private func generateRandomNumber(from numbers: [Int]) -> Int? {
        guard !numbers.isEmpty else {
            print("The array is empty")
            return nil
        }

        let randomIndex = Int.random(in: 0..<numbers.count)
        return numbers[randomIndex]
    }

    private let numbersArray = [8300, 8301, 8302, 8305, 8306, 8307, 8308, 8309, 8314, 8315, 8316, 8317, 8400, 8401, 8402, 8403, 8404, 8406, 8407, 8408, 8409, 8410]

    private lazy var url: String = {
        guard let randomNumber = generateRandomNumber(from: numbersArray) else {
            return ""
        }
        return "https://api.anilibria.tv/v2/getTitle?id=\(randomNumber)"
    }()

    func fetchAnimeTitle(completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let animeTitleName = try decoder.decode(AnimeTitleName.self, from: data)

                let animeName = animeTitleName.names.ru
                completion(.success(animeName))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}


enum NetworkError: Error {
    case invalidURL
    case noData
    case invalidData
    case invalidResponse
}




//    .onAppear(){
//        RussianеTerm.shared.printRandomDefinition()
//    }

//RussianеTerm.shared.getRandomElement { result in
//    switch result {
//    case .success(let definition):
//       print(definition)
//    case .failure(let error):
//        print("Error getting random definition: \(error)")
//    }
//}

//NetworkMovie.shared.getRandomElement {result in
//    switch result {
//    case .success(let title):
//       print(title)
//    case .failure(let error):
//        print("Error getting random movie title: \(error)")
//    }
//}

//switch result {
//case .success(let title):
//  print(title)
//case .failure(let error):
//    print("Error fetching anime title: \(error)")
//}
