//
//  APICaller.swift
//  Spotify
//
//  Created by LE BA TRONG on 28/01/2022.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    private init() {}
    
    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }
    //enum error
    enum APIError:Error {
        case faileedToGetData
    }
    // MARK: - Search search?type=album&include_external=audio'
    public func search(with query:String, completion: @escaping(Result<[SearchResult],Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/search?limit=10&type=album,artist,playlist,track&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.faileedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(SearchResultsReponse.self, from: data)
                    var searchResults: [SearchResult] = []
                    searchResults.append(contentsOf: result.albums.items.compactMap{(SearchResult.album(model: $0))})
                    searchResults.append(contentsOf: result.tracks.items.compactMap{(SearchResult.track(model: $0))})
                    searchResults.append(contentsOf: result.artists.items.compactMap{(SearchResult.artist(model: $0))})
                    searchResults.append(contentsOf: result.playlists.items.compactMap{(SearchResult.playlist(model: $0))})
                    completion(.success(searchResults))
                } catch  {
                    
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    // MARK: - Category
    public func getCategories(completion: @escaping (Result<[Category],Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/categories?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data , error == nil else {
                    return
                }
                do {
                    let result = try JSONDecoder().decode(AllCategoriesReponse.self, from: data)
//                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    
                    completion(.success(result.categories.items))
                } catch  {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getCategoryPlaylist(category: Category,completion: @escaping (Result<[Playlist],Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/categories/\(category.id)/playlists?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data , error == nil else {
                    return
                }
                do {
                    let result = try JSONDecoder().decode(FeaturedPlaylistsResponse.self, from: data)
                    let playlists = result.playlists.items
                    completion(.success(playlists))
                } catch  {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    //enum method
    enum HTTPMethod:String {
        case GET
        case POST
    }
    //Create-add-remove-save playlist music
    public func getCurrentUserPlaylists(completion:@escaping(Result<[Playlist],Error>) ->Void) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/me/playlists"),
            type: .GET) { request in
                let task = URLSession.shared.dataTask(with: request) { data, _, error in
                    guard let data = data, error == nil else {
                        completion(.failure(APIError.faileedToGetData))
                        return
                    }
                    do {
                        let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                        print(result)
                    } catch  {
                        print(error.localizedDescription)
                    }
                    
                   
                }
                task.resume()
        }
    }
    //create playlist
    public func cratePlaylists(with name:String, completion:@escaping(Result<Bool,Error>) -> Void) {
        
    }
    //add track to playlist
    public func addTrackToPlaylist(
        track: AudioTrack,
        playlist:Playlist,
        completion:@escaping(Result<Bool, Error>) -> Void) {
        
    }
    
    public func removeTrackFromToPlaylist(
        track: AudioTrack,
        playlist:Playlist,
                                          completion:@escaping(Result<Bool, Error>) -> Void ) {
        
    }
    // MARK: - Profile
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/me"),
            type: .GET
        ) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.faileedToGetData))
                    return
                }

                do {
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    // MARK: - Album
    public func getAlbumDetails(for album: Album, completion: @escaping (Result<AlbumDetailsReponse, Error>) -> Void) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/albums/" + album.id),
            type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.faileedToGetData))
                    return
                }

                do {
                    let result = try JSONDecoder().decode(AlbumDetailsReponse.self, from: data)
                   // print("result \(result)")
                   completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }

    
    // MARK: - Playlist
    public func getPlaylistDetails(for playlist:Playlist, completion: @escaping((Result<PlaylistDetailsResponse, Error>)) ->Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/playlists/" + playlist.id), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    return
                    
                }
                do {
                    let result = try JSONDecoder().decode(PlaylistDetailsResponse.self, from: data)
                   
                    completion(.success(result))
                } catch  {
                   
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
    }
    // MARK: - Browser
    public func getNewReleases(completion: @escaping ((Result<NewReleasesResponse, Error>)) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/new-releases?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.faileedToGetData))
                    return
                }

                do {
                    //let result =
                    let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                    print(result)
                    completion(.success(result))
                }
                catch {
                    
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    // MARK: - get featured-playlists
    public func getFeaturedPlayLists(completion:@escaping((Result<FeaturedPlaylistsResponse,Error>)) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/featured-playlists?limit=20"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                do {
//                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    let result = try JSONDecoder().decode(FeaturedPlaylistsResponse.self, from: data)
                    completion(.success(result))
                    
                } catch  {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    // MARK: - recommendations
    public func getRecommendations(genres: Set<String>, completion:@escaping((Result<RecommendationsResponse, Error>))-> Void) {
        let seeds = genres.joined(separator: ",")
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/recommendations?limit=40&seed_genres=\(seeds)"),
            type: .GET
        )  { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                do {
//                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    let result = try JSONDecoder().decode(RecommendationsResponse.self, from: data)
                    completion(.success(result))
                } catch  {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    // MARK: - gerRecommendedGenres
    public func getRecommendedGenres(completion:@escaping((Result<RecommendedGenresResponse,Error>))->Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/recommendations/available-genre-seeds" ), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                do {
                    let result = try JSONDecoder().decode(RecommendedGenresResponse.self, from: data)
                    completion(.success(result))
                } catch  {
                    
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
        //create request
        private func createRequest(with url:URL?,
                                   type:HTTPMethod,
                                   completion: @escaping(URLRequest)->Void){
            AuthManager.shared.withValidToken { token in
                guard let apiURL = url else {
                    return
                }
                var request = URLRequest(url: apiURL)
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                request.httpMethod = type.rawValue
                request.timeoutInterval = 30
                completion(request)
            }
        }
}
