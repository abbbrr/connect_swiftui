import Foundation

//Movie Films
struct MovieResponse: Decodable {
    let page: Int
    let results: [Movie]
}

struct Movie: Decodable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let poster_path:String
    let vote_average:Float

    enum CodingKeys: String, CodingKey {
        case id, title, overview, releaseDate = "release_date", poster_path = "poster_path", vote_average = "vote_average"
    }
}

//Russian Terms
struct RussianTermResponce: Decodable{
    let def:[DictionaryDefinition]
}

struct DictionaryDefinition: Decodable{
    let tr:[TrDefinition]
}

struct TrDefinition:Decodable{
    let text:String
}



//Anime Name
struct AnimeTitleName: Decodable{
    let id: Int
    let code: String
    let names:AnimeName
}

struct AnimeName:Decodable{
    let ru:String
}



