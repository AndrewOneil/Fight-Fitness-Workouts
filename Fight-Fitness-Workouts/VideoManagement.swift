import Foundation

let APIKey = pexelsInfo.APIKey
//enum will be used to iterate through the query strings for the top videos from pexels API
enum Query: String, CaseIterable {
    case Boxing, Training, Fitness, Gym, Workouts
}

//video manager class is used to retrieve videos based on selected query
class VideoManager: ObservableObject {
    @Published private(set) var videos: [Video] = []
    @Published var selectedQuery: Query = Query.Boxing {
        didSet {
            Task.init {
                await findVideos(topic: selectedQuery)
            }
        }
    }
    init() {
        Task.init{
            await findVideos(topic: selectedQuery)
        }
    }
    //function makes API request and passes the selected query in as the search query, decodes the response body
    func findVideos(topic: Query) async {
        do {
            guard let url = URL(string: "https://api.pexels.com/videos/search?query=\(topic)&per_page=10&orientation=portrait") else { fatalError("Missing URL") }
            var urlRequest = URLRequest(url: url)
            
            //includes API key and specifies HTTP Authorization Header
            urlRequest.setValue("\(APIKey)", forHTTPHeaderField: "Authorization")
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error While Fetching Data")}
            
            let decoder = JSONDecoder()
            //converts the response from snakecase into camel case
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(ResponseBody.self, from: data)
            
            DispatchQueue.main.async {
                self.videos = []
                self.videos = decodedData.videos
            }
            
        } catch {
            //displays error message if function cannot retrieve videos from pexels API
            print("Error fetching data from Pexels: \(error)")
        }
        
    }
}

//Response body follow the exact structure of the JSON response from pexels API
struct ResponseBody: Decodable {
    var page: Int
    var perPage: Int
    var totalResults: Int
    var url: String
    var videos: [Video]
}
//Video follows the exact structure of the video object from the API response
struct Video: Identifiable, Decodable {
    var id: Int
    var image: String
    var duration: Int
    var user: User
    var videoFiles: [VideoFile]
    
    struct User: Identifiable, Decodable {
        var id: Int
        var name: String
        var url: String
    }
    
    struct VideoFile: Identifiable, Decodable {
        var id: Int
        var quality: String
        var fileType: String
        var link: String
    }
}
